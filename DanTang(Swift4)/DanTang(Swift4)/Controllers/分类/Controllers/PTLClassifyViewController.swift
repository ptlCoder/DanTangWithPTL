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
    
    lazy var collections = [PTLCollection]()
    lazy var styleArray = [PTLGroup]()
    lazy var classArray = [PTLGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(UINib(nibName: "PTLSpecialCell", bundle: nil), forCellReuseIdentifier: PTLSpecialCell.cellID())
        tableView.register(UINib(nibName: "PTLStyleCell", bundle: nil), forCellReuseIdentifier: PTLStyleCell.cellID())
        tableView.register(UINib(nibName: "PTLClassCell", bundle: nil), forCellReuseIdentifier: PTLClassCell.cellID())
        
        // 加载数据
        loadSpecialSourceFromNet()
        loadStyleSourceFromNet()
    }
}

extension PTLClassifyViewController{
    func loadSpecialSourceFromNet() {
        
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BaseUrl + "v1/collections"
        let params = ["limit": 6,
                      "offset": 0]

        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
            SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.show(withStatus: message)
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
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BaseUrl + "v1/channel_groups/all"
        Alamofire
            .request(url, method: .get)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
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
extension PTLClassifyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        }else if indexPath.section == 1 {
            return (kScreenWidth-(4+1)*20)/4 + 40 + 30 + 10
        }
        return (kScreenWidth-(4+1)*20)/4 * 2 + 40 * 2 + 30 + 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let SpecialCell = tableView.dequeueReusableCell(withIdentifier: PTLSpecialCell.cellID(), for: indexPath) as! PTLSpecialCell
            SpecialCell.getData(collections)
            cell = SpecialCell
            
        }else if indexPath.section == 1{
            let StyleCell = tableView.dequeueReusableCell(withIdentifier: PTLStyleCell.cellID(), for: indexPath) as! PTLStyleCell
            StyleCell.getData(styleArray)
            cell = StyleCell
        }else
        {
            let ClassCell = tableView.dequeueReusableCell(withIdentifier: PTLClassCell.cellID(), for: indexPath) as! PTLClassCell
            ClassCell.getData(classArray)
            ClassCell.delegate = self
            cell = ClassCell
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}

extension PTLClassifyViewController: PTLClassCellDelegate {
    func classCell(_ classCell: PTLClassCell, selectCellDidAt itemId: Int) {
        let vc = PTLClassViewController()
        vc.itemID = itemId
        navigationController?.pushViewController(vc, animated: true)
    }
}
