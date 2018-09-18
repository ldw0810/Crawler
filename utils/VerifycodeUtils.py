# coding=utf-8
# Author liudewei 2017/04/26 19:25

import re
import os
import sys
from PIL import Image, ImageEnhance
from utils.pytesser import pytesser


def getVerifyCode(imageName, isNeedDispose=0, resultType=2):
    """
    :param imageName: 必须在/images目录下，参数直接是图片名称即可
    :param isNeedDispose: 是否需要进行进一步图片灰化、二值化处理，默认不处理
    :param resultType: 返回值的类型，0--纯字母  1--纯数字  默认其他--字母+数字
    :return:
    """
    # 二值化
    threshold = 140
    table = []
    for i in range(256):
        if i < threshold:
            table.append(0)
        else:
            table.append(1)

    # 对于识别成字母的修正为数字
    rep_str = {
        'O': '0',
        'o': '0',
        'I': '1',
        'i': '1',
        'L': '1',
        'l': '1',
        'Z': '2',
        'S': '5',
        's': '5',
        'b': '6',
        'g': '9',
        'q': '9',
    }
    # 对于识别成数字的修正为字母
    rep_num = {
        "0": "O",
        "1": "I",
        "2": "Z",
        "5": "S",
        "6": "b",
        "9": "g"
    }
    # 打开图片
    im = Image.open(imageName)
    if isNeedDispose:
        # 转化到灰度图
        img_gray = im.convert('L')
        # 保存图像
        # 二值化，采用阈值分割法，threshold为分割点
        image_binary = img_gray.point(table, '1')
        # 对比度增强
        image_contrast = ImageEnhance.Contrast(image_binary)
        image_final = image_contrast.enhance(2)
    else:
        image_final = im
    # 切换路径
    os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + r"\utils\pytesser")
    # 得到验证码
    image_text = pytesser.image_to_string(image_final).strip()
    if resultType == 1:
        # 字母转为数字
        for r in rep_str:
            image_text = image_text.replace(r, rep_str[r])
        image_text = re.sub(r"[^0-9]*", "", image_text)
    elif resultType == 0:
        # 数字转为字母
        for r in rep_num:
            image_text = image_text.replace(r, rep_num[r])
        image_text = re.sub(r"[^a-zA-Z]*", "", image_text)
    else:
        image_text = re.sub(r"[^a-zA-Z0-9]*]", "", image_text)
    return image_text


def checkVerifyCode(tempCode="", verifyCodeLength=4):
    if not tempCode or len(tempCode) != verifyCodeLength:
        return False
    return True


if __name__ == "__main__":
    print getVerifyCode("screenshot_cut_0.jpg")
