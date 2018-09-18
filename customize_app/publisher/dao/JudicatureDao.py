#coding=utf-8
from customize_app.publisher.beans.JudicatureTable import JudicatureTable
from dao.BaseDao import Session, with_session
from customize_app.screenApi.ScreenInfoDao import randomlist
@with_session
def quertJudicature(id):
    juidicature = Session.query(JudicatureTable).filter(JudicatureTable.id==id,
                                                 JudicatureTable.delFlag==0).first()
    randomList = randomlist(7)
    juidicature.saving_cnt += randomList[0]
    juidicature.saved_cnt += randomList[1]
    juidicature.changed_cnt += randomList[2]
    juidicature.compromise_cnt += randomList[3]
    juidicature.pursue_cnt += randomList[4]
    juidicature.adjudged_cnt += randomList[5]
    Session.flush()
    Session.commit()
    return juidicature


