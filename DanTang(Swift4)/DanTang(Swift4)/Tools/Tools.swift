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
func RGBAColor(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 屏幕的宽
let kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高
let kScreenHeight = UIScreen.main.bounds.size.height
