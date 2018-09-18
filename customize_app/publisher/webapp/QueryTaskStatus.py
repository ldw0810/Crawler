from sqlalchemy import text

from customize_app.publisher import WebSocket
from customize_app.publisher.beans.TaskStatusTable import TaskStatusInfoField
from dao import BaseDao
from utils.JsonUtils import stringify
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app


@app.route("/queryTaskStatusByTaskJobId", methods=['POST', 'GET'])
def queryTaskStatusByTaskJobId():
    params = loadParams()
    taskJobId = params["taskJobId"]
    data = BaseDao.query(TaskStatusInfoField, text('task_job_id="'+taskJobId+'"'))
    json = stringify(data).encode("utf8")
    # WebSocket.sendMessage("{'action':'queryTaskStatusByTaskJobId','data':" + json + ",'returnCode':'0','returnMsg':'SUCCESS'}")
    return parseResponse(0, {"data": data})