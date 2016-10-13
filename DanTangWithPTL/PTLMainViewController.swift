//
//  PTLMainViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

         tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        addChildViewControllers()
    }

     private func addChildViewControllers() {
    
        addChildViewController("PTLDanTangViewController", title:"单糖" , imageName: "TabBar_home_23x23_")
        addChildViewController("PTLProductViewController", title:"单品" , imageName: "TabBar_gift_23x23_")
        addChildViewController("PTLClassifyViewController", title:"分类" , imageName: "TabBar_category_23x23_")
        addChildViewController("PTLMyViewController", title:"我" , imageName: "TabBar_me_boy_23x23_")
    }
    
    
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        let nav = PTLNavigationController(rootViewController: vc)
        
        addChildViewController(nav)
    }
    
}
