//
//  PTLNavigationController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/22.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SVProgressHUD

class PTLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 导航栏背景颜色
        navigationBar.barTintColor = RGBAColor(245, g: 80, b: 83, a: 1)
        
        // 中间标题颜色
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(20), NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // 两边按钮的颜色
        navigationBar.tintColor = UIColor.whiteColor()

    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}


extension PTLNavigationController {
    /**
     统一所有控制器导航栏左上角的返回按钮
     
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true;
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: #selector(backButtonClick))
        }

        super.pushViewController(viewController, animated: true)
    }
    
    func backButtonClick() {
        
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.sharedApplication().networkActivityIndicatorVisible {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        popViewControllerAnimated(true)
    }
}
