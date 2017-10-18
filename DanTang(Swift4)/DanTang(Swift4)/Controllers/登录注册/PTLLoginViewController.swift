//
//  PTLLoginViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/22.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit


class PTLLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBarButtonItem()
    }


    
}

extension PTLLoginViewController {
    
    func setupBarButtonItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButtonClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerButtonClick))
        
    }
    
    
    // MARK: 取消
    @objc func cancelButtonClick() {
        
        dismiss(animated: true, completion: nil)
    }
    // MARK: 注册
    @objc func registerButtonClick() {
    
        let registerVC = PTLRegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
