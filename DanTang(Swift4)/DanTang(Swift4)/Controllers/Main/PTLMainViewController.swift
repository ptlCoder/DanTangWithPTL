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

        tabBar.tintColor = RGBAColor(245, g: 80, b: 83, a: 1.0)
        addChildViewControllers()
    }

    fileprivate func addChildViewControllers() {
    
        addChildViewController(PTLDanTangViewController(), title:"单糖" , imageName: "TabBar_home_23x23_")
        addChildViewController(PTLProductViewController(), title:"单品" , imageName: "TabBar_gift_23x23_")
        addChildViewController(PTLClassifyViewController(), title:"分类" , imageName: "TabBar_category_23x23_")
        addChildViewController(PTLMyViewController(), title:"我" , imageName: "TabBar_me_boy_23x23_")

    }
    fileprivate func addChildViewController(_ vc: UIViewController, title: String, imageName: String) {

        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        let nav = PTLNavigationController(rootViewController: vc)

        addChildViewController(nav)
    }
}
