//
//  PTLMyViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLMyViewController: UIViewController {
    
    @IBOutlet weak var goodsButton: UIButton!
    @IBOutlet weak var specialButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var withConstaint: NSLayoutConstraint!
    var y:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

//        goodsButton.tag = 1000
//        specialButton.tag = 1001

        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        for i in 0 ..< 2 {
            let viewVC = ViewController1()
            addChildViewController(viewVC)
            print(scrollView.frame)
            viewVC.view.frame = CGRect(x: kScreenWidth*CGFloat(i), y: 64, width: kScreenWidth, height: kScreenHeight-64-49);
            scrollView.addSubview(viewVC.view);
            if i == 0 {
                 viewVC.view.backgroundColor = UIColor.blue
            }else
            {
                viewVC.view.backgroundColor = UIColor.yellow
            }
        }

        withConstaint.constant = 2 * kScreenWidth;
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

    }

    
    @IBAction func changeButtonClick(_ sender: AnyObject) {
        scrollView.setContentOffset(CGPoint(x: (CGFloat(sender.tag)-1000)*kScreenWidth, y: 0), animated: true)
    }
}
