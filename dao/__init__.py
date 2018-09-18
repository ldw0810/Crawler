#coding=utf-8
import logging
from sqlalchemy import create_engine
from sqlalchemy.pool import NullPool
import sys

import Settings
from Settings import LoggerLevel,SqlLoggerLevel
from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP
reload(sys)
sys.setdefaultencoding('utf-8')
db_config={
    'host': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_HOST),
    'user': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_USERNAME),
    'passwd':ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_PASSWD),
    'db':ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_DBNAME),
    'charset':ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_ENCODE),
    'port':ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_PORT)
}
baseEngine = create_engine('mysql://%s:%s@%s:%s/%s?charset=%s'%(db_config['user'],
                                                         db_config['passwd'],
                                                         db_config['host'],
                                                         db_config['port'],
                                                         db_config['db'],
                                                         db_config['charset']),pool_recycle=1800,echo=False,encoding='utf8', isolation_level="READ COMMITTED",convert_unicode=True)
logging.basicConfig(level=LoggerLevel,
                        format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s')
logging.getLogger('sqlalchemy.engine').setLevel(Settings.SqlLoggerLevel)



