# -*- coding: utf-8 -*-

from flask import send_file
from utils.ResponseUtils import parseResponse
from utils.RequestUtils import loadParams
from dao import TemplateDao
from dao import BaseDao
from web import app
from utils import AdUtil

@app.route("/screenshot",methods=['POST','GET'])
def qrcode():
    params = loadParams()
    job_temp_id = params.get('job_template_id')
    field_id = params.get('field_id')
    field_name = params.get('field_name')
    job_template = TemplateDao.queryJobTemplate(job_temp_id)
    table_name = job_template.tableName
    ad_target_url = get_result(table_name,field_name,field_id)
    file_path = AdUtil.take_screenshot(ad_target_url)
    if file_path:
        return send_file(file_path, mimetype='image/png')
    else:
        return parseResponse(-1)
def get_result(table_name,field_name, field_id):
    sql = """select %s from %s where id='%s'""" % (field_name, table_name, field_id)
    result = BaseDao.execute(sql)
    if result and len(result.cursor._rows)>0:
        return result.cursor._rows[0][0]
    return False
if __name__=="__main__":
    app.run()
    # get_result('data_job_tx_gg','screenshot_path','069fc5b0-4f33-11e7-b2fd-00232490c701')