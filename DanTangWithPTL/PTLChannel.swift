//
//  PTLChannel.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/9.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLChannel: NSObject {

    var editable: Bool?
    var id: Int?
    var name: String?
    
    init(dict: [String: AnyObject]) {
        editable = dict["editable"] as? Bool
        id = dict["id"] as? Int
        name = dict["name"] as? String
    }
}
