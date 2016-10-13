//
//  PTLClassifyViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class PTLClassifyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var collections = [PTLCollection]()
    private lazy var styleArray = [PTLGroup]()
    private lazy var classArray = [PTLGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "PTLSpecialCell", bundle: nil), forCellReuseIdentifier: PTLSpecialCell.cellID())
        tableView.registerNib(UINib(nibName: "PTLStyleCell", bundle: nil), forCellReuseIdentifier: PTLStyleCell.cellID())
        tableView.registerNib(UINib(nibName: "PTLClassCell", bundle: nil), forCellReuseIdentifier: PTLClassCell.cellID())
        
        // 加载数据
        loadSpecialSourceFromNet()
        loadStyleSourceFromNet()
    }
}

extension PTLClassifyViewController{
    func loadSpecialSourceFromNet() {
        
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BaseUrl + "v1/collections"
        let params = ["limit": 6,
                      "offset": 0]
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
            SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showWithStatus(message)
                    return
                }
                if let data = dict["data"].dictionary {
                    if let collectionData = data["collections"]?.arrayObject {
                    
                        
                        for item in collectionData {
                            let model = PTLCollection(dict: item as! [String : AnyObject])
                            self.collections.append(model)
                        }
                        self.tableView.reloadData()
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    func loadStyleSourceFromNet() {
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BaseUrl + "v1/channel_groups/all"
        Alamofire
            .request(.GET, url)
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
                    
                    if let data = dict["data"].dictionary {
                        if let channel_groups = data["channel_groups"]?.arrayObject {
                           
                            let styleArr = channel_groups[0] as! [String: AnyObject]
                            for dict in (styleArr["channels"] as! [AnyObject]){
                                // 字典转模型
                                let styleModel = PTLGroup(dict: dict as! [String : AnyObject])
                                self.styleArray.append(styleModel)
                            }
                            let classArray = channel_groups[1] as! [String: AnyObject]
                            for dict in (classArray["channels"] as! [AnyObject]){
                                let classModel = PTLGroup(dict: dict as! [String : AnyObject])
                                self.classArray.append(classModel)
                            }

                            self.tableView.reloadData()
                            SVProgressHUD.dismiss()
                        }
                    }
                }
        }
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource


extension PTLClassifyViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    } 

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 140
        }else if indexPath.section == 1 {
            return (kScreenWidth-(4+1)*20)/4 + 40 + 30 + 10
        }
        return (kScreenWidth-(4+1)*20)/4 * 2 + 40 * 2 + 30 + 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            let SpecialCell = tableView.dequeueReusableCellWithIdentifier(PTLSpecialCell.cellID(), forIndexPath: indexPath) as! PTLSpecialCell
            
            SpecialCell.getData(collections)
            cell = SpecialCell
            
        }else if indexPath.section == 1{
            let StyleCell = tableView.dequeueReusableCellWithIdentifier(PTLStyleCell.cellID(), forIndexPath: indexPath) as! PTLStyleCell
            StyleCell.getData(styleArray)
            cell = StyleCell
        }else
        {
            let ClassCell = tableView.dequeueReusableCellWithIdentifier( PTLClassCell.cellID(), forIndexPath: indexPath) as! PTLClassCell
            ClassCell.getData(classArray)
            cell = ClassCell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}

