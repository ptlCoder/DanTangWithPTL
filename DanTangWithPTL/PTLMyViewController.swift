//
//  PTLMyViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/7.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLMyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var headerView = PTLHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.hidden = true
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        headerView =  NSBundle.mainBundle().loadNibNamed("PTLHeaderView", owner: nil, options: nil)?[0] as! PTLHeaderView
         headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: myVCHeaderViewHeight)
        
        tableView.tableHeaderView = headerView
        
        // MARK: - 头视图事件
        headerViewClick()
    }
}

extension PTLMyViewController {
    
    func headerViewClick() {
        
        headerView.messageButton.addTarget(self, action: #selector(messageButtonClick), forControlEvents: .TouchUpInside)
       
         headerView.settingButton.addTarget(self, action: #selector(settingButtonClick), forControlEvents: .TouchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(iconImageViewClick))
        headerView.iconImageView .addGestureRecognizer(tap)
        headerView.iconImageView.userInteractionEnabled = true
    }
    
    // MARK: 消息事件
    func messageButtonClick(){
        print(#function)
    }
    // MARK: 设置事件
    func settingButtonClick(){
        print(#function)
    }
    // MARK: 头像事件
    func iconImageViewClick() {
        print(#function)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PTLMyViewController:UITableViewDelegate, UITableViewDataSource {
    

    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

         let view =  NSBundle.mainBundle().loadNibNamed("PTLSectionView", owner: nil, options: nil)?[0] as! PTLSectionView
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 39
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY : CGFloat = scrollView.contentOffset.y
        
        if offsetY < myVCHeaderViewHeight {
            tableView.backgroundView = UIImageView(image: UIImage(named: "Me_ProfileBackground"))
        }else
        {
            tableView.backgroundView = nil
        }
    }
}
