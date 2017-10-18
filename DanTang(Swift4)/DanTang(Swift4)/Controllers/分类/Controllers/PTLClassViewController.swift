//
//  PTLClassViewController.swift
//  DanTang(Swift4)
//
//  Created by soliloquy on 2017/10/11.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PTLClassViewController: UIViewController {

    var itemID:Int!
    lazy var array = [PTLClassDes]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: 请求数据
       getDataSourceFromNet()
    }
}

extension PTLClassViewController {
    
    func getDataSourceFromNet() {
        
        let url = BaseUrl + "v1/channels/\(itemID ?? 0)/items"
        print(url)
        let parames = ["limit" : 20, "offset" : 0]
        SVProgressHUD.show(withStatus: "正在加载...")
        Alamofire.request(url, method: .get, parameters: parames).responseJSON { (response) in
            guard response.result.isSuccess else {
                print("Error")
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                
                if let data = dict["data"].dictionary {
                    let  dictArr = data["items"]?.arrayObject
                    
                    for item in dictArr! {
                      let classModel = PTLClassDes(dict: item as! [String : AnyObject])
                        self.array.append(classModel)
                        // 刷新
                        
                        SVProgressHUD.dismiss()
                    }
                    print(self.array.count)
                }
            }
        }
    }
//    id = 12
    // http://api.dantangapp.com/v1/channels/12/items?limit=20&offset=0
}
