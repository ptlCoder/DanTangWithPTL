//
//  PTLDanTangViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PTLDanTangViewController: YZDisplayViewController {

    /// 标题数据源
    lazy var arrModel = [PTLChannel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTitleData()
        
    }
}

extension PTLDanTangViewController {
    
  @objc private func loadTitleData() {
        let url = BaseUrl + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
            
            guard response.result.isSuccess else {
                
                SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfoWithStatus(message)
                    return
                }
                
                SVProgressHUD.dismiss()
                let data = dict["data"].dictionary
                if let channels = data!["channels"]?.arrayObject {
                    for dictName in channels{
                       let model = PTLChannel(dict: dictName as! [String : AnyObject])
                        self.arrModel.append(model)
                    }
                    
                    self.setTitles()
                    self.setUpAllViewController()
                    // 刷新
                    self.refreshDisplay()
                }
            }
        }
    }
}

extension PTLDanTangViewController {
    // MARK: 添加所有子控制器
    @objc private func setUpAllViewController() {
        
        for i in 0..<arrModel.count {
            let vc1 = PTLChildViewController()
            vc1.title = arrModel[i].name
            vc1.type = arrModel[i].id!
            addChildViewController(vc1)
        }
    }

    // MARK: 设置标题
    @objc private func setTitles(){
    
        setUpTitleEffect { (titleScrollViewColor, norColor, selColor, titleFont, titleHeight, titleWidth) in
            
            // 设置标题滚动条背景
            titleScrollViewColor.memory = RGBAColor(236, g: 236, b: 236, a: 1)
            
            norColor.memory = UIColor.blackColor()
            selColor.memory = UIColor.redColor()
            titleWidth.memory = kScreenWidth/5
            
        }

        setUpUnderLineEffect { (isUnderLineDelayScroll, underLineH, underLineColor, isUnderLineEqualTitleWidth) in
            isUnderLineEqualTitleWidth.memory = true
        }
        
        
        // 字体缩放
        // 推荐方式 (设置字体缩放)
//        setUpTitleScale { (titleScale) in
//            titleScale.memory = 1.3
//        }
    }
}
