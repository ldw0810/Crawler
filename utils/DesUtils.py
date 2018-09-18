# coding=utf-8
import base64
from utils.ConfigUtils import getDesPorperties

key=getDesPorperties("key","aaaaaaaa");
secret=getDesPorperties("secret","abcdefgh");
#加密
def encrypt(data):
    return base64.encodestring(data)
#解密
def decrypt(data):
    # print k.decrypt("�N�r9��.�O��E�")
    return base64.decodestring(data)

#测试方法a
if __name__=="__main__":
    # k = des(key, CBC, secret, pad=None, padmode=PAD_PKCS5)
    a= base64.encodestring("中国")
    print a
    print base64.decodestring(a)
    # print "%r"%(a)
    # b=a
    # data = "Please encrypt my data"
    # k = pyDes.des("abcdefde", pyDes.CBC, "12345678", pad=None, padmode=pyDes.PAD_PKCS5)
    # d = k.encrypt(data)
    # print d
    # print "Decrypted: %r" % k.decrypt('\xb0\x92\\\xd1@y\x9f\x1aQ\x1dp\xe2rG\xeb\xc4\x8cp=u\xd7|\x15\xea')
    # a=k.encrypt("asdas123")
    # b= "%r" % binascii.b2a_hex(a)
    # print b
    # c="%r" % binascii.a2b_hex(binascii.b2a_hex(a))
    # print decrypt(c)+"bbb"
    # print len("%s"%("�N�r9��.�O��E�"))
    # print decrypt("%r"%("�N�r9��.�O��E�"))+"==="
    # print decrypt('�N�r9��.�O��E�')
    # print decrypt("�N�r9��.�O��E�")+"==="
    # print k.decrypt("�N�r9��.�O��E�")
