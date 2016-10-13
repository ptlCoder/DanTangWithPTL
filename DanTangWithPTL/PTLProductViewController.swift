//
//  PTLProductViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import MJRefresh

class PTLProductViewController: UIViewController {

    lazy var dataSource = [AnyObject]()
    
    var next_url:String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册
        let nib = UINib(nibName: String(PTLProductCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "CellID")
        
        // 添加刷新
        setupMJfreshing()
    }
    
    // MARK: mj刷新
    func setupMJfreshing() {
        
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        collectionView.mj_header.beginRefreshing()
    }

}


// MARK: - 请求数据
extension PTLProductViewController {
    
    // MARK: 加载最新数据
    @objc private func loadNewData() {
        SVProgressHUD.showWithStatus("加载中...")
        let url = BaseUrl + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            
            self.dataSource.removeAll()
            
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfoWithStatus(message)
                    return
                }
                
                SVProgressHUD.dismiss()
                
                if let data = dict["data"].dictionary {
                    
                    // 获取下一页的接口
                    if let moreUrl = data["paging"]?.dictionaryObject{
                        
                        self.next_url = moreUrl["next_url"] as? String
                    }
                    
                    if let items = data["items"]?.arrayObject {
                        for item in items {
                            if let itemData = item["data"] {
                                let product = PTLProduct(dict: itemData as! [String: AnyObject])
                                self.dataSource.append(product)
                            }
                        }
                        // 刷新
                        self.collectionView.reloadData()
                        self.collectionView.mj_header.endRefreshing()
                        self.collectionView.mj_footer.endRefreshing()
                    }
                }
            }
        }
    }
    
    // MARK: 加载更多数据
    @objc private func loadMoreData() {
    
        guard (next_url != nil) else {
            self.collectionView.mj_footer.endRefreshing()
            return
        }
            Alamofire.request(.GET, next_url!).responseJSON { (response) in
                guard response.result.isSuccess else{
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
                
                if let data = dict["data"].dictionary {
                    
                    // 获取下一页的接口
                    if let moreUrl = data["paging"]?.dictionaryObject{
                        
                        self.next_url = moreUrl["next_url"] as? String
                    }
                    
                    if let items = data["items"]?.arrayObject {
                        for item in items {
                            if let itemData = item["data"] {
                                let product = PTLProduct(dict: itemData as! [String: AnyObject])
                                self.dataSource.append(product)
                            }
                        }
                        // 刷新
                        self.collectionView.reloadData()
                        self.collectionView.mj_header.endRefreshing()
                        self.collectionView.mj_footer.endRefreshing()
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PTLProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PTLProductCellDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView.mj_footer.hidden = (dataSource.count == 0)
        return dataSource.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellID",forIndexPath: indexPath) as! PTLProductCell
        cell.product = dataSource[(indexPath as NSIndexPath).item] as? PTLProduct
        cell.delegate = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: NSIndexPath) {
        
        let vc = PTLDetailGoodsViewController()
        vc.product = dataSource[(indexPath as NSIndexPath).item] as? PTLProduct
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (kScreenWidth - 20) / 2
        let height: CGFloat = 230
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - PTLProductCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        
        let logVC = PTLLoginViewController()
        let nav = PTLNavigationController(rootViewController: logVC)
        logVC.title = "登录"
        presentViewController(nav, animated: true, completion: nil)
    }
}
