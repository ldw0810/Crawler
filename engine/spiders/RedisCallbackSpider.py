import json
import logging
from scrapy_redis import defaults
from scrapy_redis.spiders import RedisCrawlSpider
from twisted.internet import reactor

from beans.TaskTable import TaskStatus
from beans.UrlTable import UrlClazz, UrlStatus
from dao import TaskJobDao
from dao import UrlDao
from dao.TaskJobDao import loadTaskJobHistoryById
from utils import LicenseUtils

from utils import ConfigUtils
from utils import RedisUtils
from utils.ConfigUtils import KEYMAP
from utils.ExportExcelUtils import get_ip
from utils.HashFilter import YHash
from utils import RedisUtils

hashswitch = ConfigUtils.getRedisPorperties(KEYMAP.DISTRIBUTED_SPIDER_SWITCH) == str(True)
NodeList = ConfigUtils.getRedisPorperties(KEYMAP.DISTRIBUTED_SPIDER_NODE_LIST).split(',')
localIP = get_ip()
tjs = YHash(NodeList, int(ConfigUtils.getRedisPorperties(KEYMAP.VIRTUAL_NODE)))


class RedisCallbackSpider(RedisCrawlSpider):
    def beforeStartUrl(self, data):
        return data

    def next_requests(self):
        use_set = self.settings.getbool('REDIS_START_URLS_AS_SET', defaults.START_URLS_AS_SET)
        fetch_one = self.server.spop if use_set else self.server.lpop

        if not LicenseUtils.check_licence(LicenseUtils.get_mac_address()):
            reactor.stop()
        """Returns a request to be scheduled or none."""

        # XXX: Do we need to use a timeout here?
        found = 0
        while found < self.redis_batch_size:
            redis_key = fetch_one(self.redis_key)
            taskJobHistoryId = redis_key
            if taskJobHistoryId != None:
                taskJobHistory = loadTaskJobHistoryById(taskJobHistoryId)
                if taskJobHistory:
                    taskJobId = taskJobHistory.taskJobId
                    taskJob = TaskJobDao.loadTaskById(taskJobId)
                    if taskJob and taskJob.status == TaskStatus.PAUSE:
                        RedisUtils.lpush(ConfigUtils.getRedisPorperties(KEYMAP.ASSIST_SPIDER_REDIS_KEY),
                                         taskJobHistoryId)
                        break
                else:
                    break
            else:
                break
            if hashswitch:
                if str(localIP) != str(tjs.get_node(redis_key)):
                    RedisUtils.lpush(self.redis_key, redis_key)
                    return

            redis_key = self.redis_key + "_" + redis_key
            orginData = fetch_one(redis_key)
            data = None
            # data = fetch_one(self.redis_key)
            try:
                logging.info("orginData==" + orginData)
                orginData = json.loads(orginData)
                orginData["taskJobHistoryId"] = taskJobHistoryId
                data = self.beforeStartUrl(orginData)
            except Exception, e:
                logging.error("Error e:")
                logging.error(e)
                logging.error(orginData)
                break
            if not data:
                # Queue empty.
                logging.warning('********dataUrl is null*************')
                break
            try:
                req = self.make_request_from_data(data)
                # req.replace(meta={"id":"123"})
                req.meta["id"] = orginData.get("id")
                req.meta["dataParentId"] = orginData.get("dataParentId")
                req.meta["taskJobHistoryId"] = orginData.get("taskJobHistoryId")
                req.meta["url"] = orginData.get("url")
                urlListStatusId = req.meta["urlListStatusId"] = orginData.get("urlListStatusId")
            except Exception, e:
                logging.error("make_request_from_data:e:" + e)
                break
            if req:
                if urlListStatusId:
                    UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.RUNNING)
                else:
                    urlListStatus = UrlClazz(url=orginData.get("url"), status=UrlStatus.RUNNING,
                                             parentUrl=orginData.get("parentUrl"),
                                             taskJobId=orginData.get("id"), taskJobHistoryId=taskJobHistoryId)
                    UrlDao.addUrl(urlListStatus)
                yield req
                found += 1
            else:
                if urlListStatusId:
                    UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.FAIL, "Request not made from data")
                else:
                    urlListStatus = UrlClazz(url=orginData.get("url"), status=UrlStatus.RUNNING,
                                             parentUrl=orginData.get("parentUrl"),
                                             taskJobId=orginData.get("id"), taskJobHistoryId=taskJobHistoryId)
                    UrlDao.addUrl(urlListStatus)
                self.logger.debug("Request not made from data: %r", data)

        if found:
            self.logger.debug("Read %s requests from '%s'", found, self.redis_key)
