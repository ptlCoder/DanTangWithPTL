//
//  PTLSectionView.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/7.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLSectionView: UIView {

    @IBOutlet weak var redViewLeftContraint: NSLayoutConstraint!
    @IBOutlet weak var goodsButton: UIButton!
    @IBOutlet weak var specialButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        goodsButton.tag = 1000
        specialButton.tag = 1001
    }
    
    
    @IBAction func redViewContraintChange(sender: UIButton) {
        if sender.tag == 1000 {
            redViewLeftContraint.constant = 0
        }else
        {
            redViewLeftContraint.constant = kScreenWidth/2
        }
        
        UIView.animateWithDuration(0.25) {
            self.layoutIfNeeded()
        }
        
    }
    

}
