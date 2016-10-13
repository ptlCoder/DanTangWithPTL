//
//  Tools.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/22.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

let BaseUrl = "http://api.dantangapp.com/"

/// code 码 200 操作成功
let RETURN_OK = 200

/// RGBA的颜色设置
func RGBAColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 屏幕的宽
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
/// 屏幕的高
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
/// 头部视图高度
let myVCHeaderViewHeight: CGFloat = (kScreenWidth == 320 ? 200:250)
