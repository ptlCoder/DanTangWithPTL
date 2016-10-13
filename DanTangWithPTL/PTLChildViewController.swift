//
//  PTLChildViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/9.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import MJRefresh

class PTLChildViewController: UIViewController {

    var cover = RequesCover()
    var type = Int()
    var childItems = [PTLChildItem]()
    var next_url:String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加通知
        
        NSNotificationCenter.defaultCenter().addObserver(self,selector:#selector(setupMJfreshing), name:(rawValue: YZDisplayViewClickOrScrollDidFinshNote), object:self)
        // 蒙版
        cover = RequesCover.requestCover()
        view.addSubview(cover)
        
        // 注册
        tableView.registerNib(UINib(nibName: "PTLChildCell", bundle: nil), forCellReuseIdentifier: "PTLChildCell")
        tableView.separatorStyle = .None
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cover.frame = view.bounds
    }
    
    // MARK: mj刷新
    func setupMJfreshing() {

        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        tableView.mj_header.beginRefreshing()
    }
    
    // 加载更多
    func loadMoreData() {
        
        guard (next_url != nil) else {
            self.tableView.mj_footer.endRefreshing()
            return
        }
        
        Alamofire
            .request(.GET, next_url!)
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
                    
                    let data = dict["data"].dictionary
                    // 获取下一页的接口
                    if let moreUrl = data!["paging"]?.dictionaryObject {
                        
                        self.next_url = moreUrl["next_url"] as? String
                    }
                    if let items = data!["items"]?.arrayObject{
                        for item in items {
                            let childItem = PTLChildItem(dict: item as! [String : AnyObject])
                            self.childItems.append(childItem)
                        }
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.mj_footer.endRefreshing()
                        self.tableView.reloadData()
                        self.cover.removeFromSuperview()
                        
                    }
                }
        }
    }
    
    // MARK: 加载最新数据
    func loadNewData() {

        let url = BaseUrl + "v1/channels/\(type)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
            
                guard response.result.isSuccess else {
                   SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                /**
                 *  移除所有数据
                 */
                self.childItems.removeAll()
                
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    
                    let data = dict["data"].dictionary
                    
                    // 获取下一页的接口
                    if let moreUrl = data!["paging"]?.dictionaryObject{
                        
                        self.next_url = moreUrl["next_url"] as? String
                    }
                    
                    // 序列化数据
                    if let items = data!["items"]?.arrayObject{
                        for item in items {
                            let childItem = PTLChildItem(dict: item as! [String : AnyObject])
                            self.childItems.append(childItem)
                        }
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.mj_footer.endRefreshing()
                        self.tableView.reloadData()
                        self.cover.removeFromSuperview()
                        
                    }
                }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension PTLChildViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.mj_footer.hidden = (childItems.count == 0)
        return childItems.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PTLChildCell", forIndexPath: indexPath) as! PTLChildCell
        cell.model = childItems[(indexPath as NSIndexPath).row]
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonClick), forControlEvents: .TouchUpInside)
        cell.likeButton.tag = indexPath.row + 100
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = PTLDetailViewController()
        detailVC.title = "攻略详情"
        detailVC.detailURL = childItems[indexPath.row].content_url!
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 175
    }
    
    
    func likeButtonClick(button: UIButton) {
        
        let row = button.tag - 100
        debugPrint("row----\(row)")
    }

}
