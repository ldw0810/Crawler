# coding:utf8
import sys,os

reload(sys)
sys.setdefaultencoding('utf8')

import xlwt

def export(tablename,resultDict,title):

    # 重置游标的位置

    # 搜取所有结果
    # 获取MYSQL里面的数据字段名称
    workbook = xlwt.Workbook(encoding='utf8')
    sheet = workbook.add_sheet('table_'+tablename,cell_overwrite_ok=True)

    # 写上字段信息
    for field in range(0,len(title)):
        sheet.write(0,field,title[field])

    # 获取并写入数据段信息

    for row in range(1,len(resultDict)+1):
        for col in range(0,len(title)):
            print resultDict[row-1][col]
            sheet.write(row,col,u'%s'%resultDict[row-1][col])
    path= os.path.dirname(os.path.realpath(__file__))
    workbook.save(tablename+'.xls')


if __name__ == "__main__":
    pass
    a=['姓名','年龄','性别']
    b=[['王亚运','12','男'],['王欣欣','12','女']]
    export('wyy',b,a)

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