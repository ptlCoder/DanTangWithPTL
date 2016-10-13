//
//  PTLClassCell.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/30.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLClassCell: UITableViewCell {

    private lazy var dataArray = [AnyObject]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
}

// MARK: - 创建button
extension PTLClassCell {
    func rankWithTotalColumnsButtonWOrButtonH(totalColumns:Int, buttonW:CGFloat, buttonH:CGFloat){
        //总列数
        let _totalColumns: Int = totalColumns
        
        //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
        let  margin: CGFloat = (kScreenWidth - CGFloat(_totalColumns) * buttonW) / (CGFloat(_totalColumns)*2);
        
        if dataArray[0].count > 0 {
            
            for index in 0 ..< dataArray[0].count{

                let buttonView = UIButton(type: .Custom);
                //行号
                let row : Int = index / totalColumns;
                //列号
                let col : Int = index % totalColumns;
                // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
                let buttonX : CGFloat = margin + CGFloat(col) * (buttonW + 2*margin);
                // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
                let buttonY : CGFloat = 40 + CGFloat(row) * (buttonH + 30);
                
                buttonView.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH);
                
                addSubview(buttonView)
                
                let url = (dataArray[0][index]as! PTLGroup).icon_url
                buttonView.sd_setImageWithURL(NSURL(string:url!), forState: UIControlState())
                // 创建label
                let label = UILabel()
                let labelX : CGFloat = buttonX
                let labelY : CGFloat = buttonView.frame.maxY
                let w:CGFloat = buttonW
                let h:CGFloat = 30
                label.frame = CGRect(x: labelX, y: labelY, width: w, height: h)
                addSubview(label)
                label.text = (dataArray[0][index]as! PTLGroup).name
                label.textColor = RGBAColor(97, g: 97, b: 97, a: 1)
                label.textAlignment = .Center
            }
        }
    }
}

extension PTLClassCell {
    func getData(array: [PTLGroup]) {
        dataArray.removeAll()
        dataArray.append(array)

        let buttonW:CGFloat = (kScreenWidth-(4+1)*20)/4
        let buttonH:CGFloat = buttonW
        rankWithTotalColumnsButtonWOrButtonH(4, buttonW: buttonW, buttonH: buttonH)
    }
}

extension PTLClassCell{
    
    // 类方法 重用标识符
    class func cellID () -> String {
        return "PTLClassCell"
    }
}
