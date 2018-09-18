#!/usr/bin/env python
# -*- coding: utf-8 -*-
from kafka import KafkaProducer
from kafka import KafkaConsumer
from kafka.errors import KafkaError
import logging
import json

para={'host':'178.16.39.103:6667,178.16.39.100:6667,10.190.220.112:6667',
 'topic':'test'}

class kafka(object):
    '''
    使用kafka的生产模块
    '''

    def __init__(self,cur_database_param):
        # super(Kafka_producer, self).__init__()
        # self.quert_db_info = super(Kafka_producer, self).getDBConfig()
        # self.kafkaHost = self.quert_db_info['host']
        # self.kafkaPort = self.quert_db_info['port']
        # self.kafkatopic = self.quert_db_info['dbname']
        self.papa=cur_database_param
        try:
            self.producer = KafkaProducer(bootstrap_servers = cur_database_param['host'],request_timeout_ms=500)
        except KafkaError as e:
            print e

    def insert(self,tablename,item,jobid):
        # dic = {'TemplateName': jobTemplate.name, 'UrlStatus': '0', 'Timestamps': int(time.time()), 'datas': sqlArray}
        log ={"tablename":tablename,'item':item,'jobid':jobid}
        return log

    def execute(self, sql):
        self.sendjsondata(sql)

    def isTableExist(self,tablaName):
        return True

    def sendjsondata(self, params):
        try:
            parmas_message = json.dumps(params)
            producer = self.producer
            producer.send(self.papa['topic'], parmas_message.encode('utf-8'))
        except KafkaError as e:

            logging.error('KafkaError Fail')


class Kafka_consumer(object):
    '''
    使用Kafka—python的消费模块
    '''

    def __init__(self, kafkahost, kafkaport, kafkatopic, groupid):
        self.kafkaHost = kafkahost
        self.kafkaPort = kafkaport
        self.kafkatopic = kafkatopic
        self.groupid = groupid
        self.consumer = KafkaConsumer(self.kafkatopic, group_id=self.groupid,bootstrap_servers = '{kafka_host}:{kafka_port}'.format(kafka_host=self.kafkaHost,kafka_port=self.kafkaPort ))


    def consume_data(self):
        try:
            for message in self.consumer:
                # print json.loads(message.value)
                yield message
        except KeyboardInterrupt, e:
            print e


def main():
    pass
    # try:
    #     producer = kafka("172.21.14.47", 9092)
    #     params = '{abetst}:{null}'
    #     producer.sendjsondata(params)
    # except Exception,e:
    #     print Exception,e
    # for id in range(10):

    #    producer.sendjsondata(params)
    ##测试消费模块
    #消费模块的返回格式为ConsumerRecord(topic=u'ranktest', partition=0, offset=202, timestamp=None,
    #\timestamp_type=None, key=None, value='"{abetst}:{null}---0"', checksum=-1868164195,
    #\serialized_key_size=-1, serialized_value_size=21)
    # consumer = Kafka_consumer('Slave1', 9092, "test", 'test-consumer-group')
    # message = consumer.consume_data()
    # for i in message:
    #   print i.value

if __name__ == '__main__':

    pass