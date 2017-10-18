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


class PTLProductViewController: UIViewController {

    lazy var dataSource = [AnyObject]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册
        collectionView.register(UINib(nibName: "PTLProductCell", bundle: nil), forCellWithReuseIdentifier: PTLProductCell.cellID())
        
        // 请求数据
        getDataSourceFromNet()
    }
    
    
}


// MARK: - 请求数据
extension PTLProductViewController {
    
    fileprivate func getDataSourceFromNet() {
        SVProgressHUD.show(withStatus: "加载中...")
        let url = BaseUrl + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
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
                
                SVProgressHUD.dismiss()
                
                if let data = dict["data"].dictionary {
                    if let items = data["items"]?.arrayObject {
                        for item in items {
                            
                            if let itemData = (item as! NSDictionary)["data"] {
                                let product = PTLProduct(dict: itemData as! [String: AnyObject])
                                self.dataSource.append(product)
                            }
                        }
                        // 刷新
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }

}

// MARK: - UICollectionViewDelegate
extension PTLProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PTLProductCellDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PTLProductCell.cellID(), for: indexPath) as! PTLProductCell
        cell.product = dataSource[indexPath.item] as? PTLProduct
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.yellow
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
        let height: CGFloat = 230
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - PTLProductCellDelegate
    func collectionViewCellDidClickedLikeButton(_ button: UIButton) {
        
        let logVC = PTLLoginViewController()
        let nav = PTLNavigationController(rootViewController: logVC)
        logVC.title = "登录"
        present(nav, animated: true, completion: nil)
    }
}
