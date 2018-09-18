# coding:utf8
import sys,os
import random
from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP
import socket
reload(sys)
sys.setdefaultencoding('utf8')

import xlwt,xlrd


def get_ip():
    try:
        csock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        csock.connect(('8.8.8.8', 80))
        (addr, port) = csock.getsockname()
        csock.close()
        return addr
    except socket.error:
        return "127.0.0.1"

def export(tablename,resultDict,title):

    # 重置游标的位置
    # 搜取所有结果
    # 获取MYSQL里面的数据字段名称
    workbook = xlwt.Workbook(encoding='utf8')
    sheet = workbook.add_sheet('table',cell_overwrite_ok=True)

    # 写上字段信息
    for field in range(0,len(title)):
        sheet.write(0,field,title[field])

    # 获取并写入数据段信息

    for row in range(1, len(resultDict)+1):
        for col in range(0, len(title)):
            sheet.write(row, col, u'%s' % resultDict[row-1][col])

    # path2= os.getcwd()
    ExcelFile=tablename+'_'+str(random.randint(100000, 999999))+'.xls'

    workbook.save("web/static/excel/"+ExcelFile)

    ip=get_ip()

    path=ip+":"+ConfigUtils.getWebPorperties(KEYMAP.PORT)

    return 'http://'+path+'/static/excel/'+ExcelFile

def open_excel(file= 'file.xls'):
    try:
        data = xlrd.open_workbook(file)
        return data
    except Exception,e:
        print str(e)

#根据索引获取Excel表格中的数据   参数:file：Excel文件路径     colnameindex：表头列名所在行的所以  ，by_index：表的索引
def excel_table_byindex(file= 'file.xls',colnameindex=0,by_index=0):
    data = open_excel(file)
    table = data.sheets()[by_index]
    nrows = table.nrows #行数
    ncols = table.ncols #列数
    colnames =  table.row_values(colnameindex) #某一行数据
    list =[]
    for rownum in range(1,nrows):

         row = table.row_values(rownum)
         if row:
             app = {}
             for i in range(len(colnames)):
                app[colnames[i]] = row[i]
             list.append(app)
    return list

#根据名称获取Excel表格中的数据   参数:file：Excel文件路径     colnameindex：表头列名所在行的所以  ，by_name：Sheet1名称
def excel_table_byname(file= 'file.xls',colnameindex=0,by_name=u'Sheet1'):
    data = open_excel(file)
    table = data.sheet_by_name(by_name)
    nrows = table.nrows #行数
    colnames =  table.row_values(colnameindex) #某一行数据
    list =[]
    for rownum in range(1,nrows):
         row = table.row_values(rownum)
         if row:
             app = {}
             for i in range(len(colnames)):
                app[colnames[i]] = row[i]
             list.append(app)
    return list
if __name__ == "__main__":
    pass


# coding:utf8
# import xlrd, xlwt

# rbook = xlrd.open_workbook('demo.xlsx')
# rsheet = rbook.sheet_by_index(0)
#
# nc = rsheet.ncols
# rsheet.put_cell(0, nc, xlrd.XL_CELL_TEXT, u'总分', None)
#
# for row in xrange(1, rsheet.nrows):
#     t = sum(rsheet.row_values(row, 1))
#     rsheet.put_cell(row, nc, xlrd.XL_CELL_NUMBER, t, None)
#
# wbook = xlwt.Workbook()
# wsheet = wbook.add_sheet(rsheet.name)
# style = xlwt.easyxf('align: vertical center, horizontal center')
#
# for r in xrange(rsheet.nrows):
#     for c in xrange(rsheet.ncols):
#         wsheet.write(r, c, rsheet.cell_value(r, c), style)
# wbook.save('output.xlsx')
#
# import xlwt
# import StringIO
# import web
# urls = (
#  '/rim_request','rim_request',
#  '/rim_export','rim_export',
#  '/(.*)', 'index'
# )
# class rim_export:
#  #render = web.template.render('adsl')
#  def GET(self):
#   web.header('Content-type','application/vnd.ms-excel')  #指定返回的类型
#   web.header('Transfer-Encoding','chunked')
#   web.header('Content-Disposition','attachment;filename="export.xls"') #设定用户浏览器显示的保存文件名
#   wb=xlwt.Workbook()
#   wb.encoding='gbk'
#   ws=wb.add_sheet('1')
#   ws.write(0,1,'123')  #如果要写中文请使用UNICODE
#   sio=StringIO.StringIO()
#   wb.save(sio)   #这点很重要，传给save函数的不是保存文件名，而是一个StringIO流
#   print sio.getvalue()
#   return sio.getvalue()
#
# a=rim_export()
# a.GET()