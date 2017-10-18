//
//  PTLGroup.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/31.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLGroup: NSObject {
    
    var status: Int?
    
    var group_id: Int?
    
    var id: Int?
    
    var items_count: Int?
    
    var order: Int?
    
    var icon_url: String?
    
    var name: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        status = dict["status"] as? Int
        group_id = dict["group_id"] as? Int
        items_count = dict["items_count"] as? Int
        id = dict["id"] as? Int
        order = dict["order"] as? Int
        icon_url = dict["icon_url"] as? String
        name = dict["name"] as? String
    }
}
