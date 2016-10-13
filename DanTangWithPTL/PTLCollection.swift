//
//  PTLCollection.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/31.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

class PTLCollection: NSObject {

    var status: Int?
    var banner_image_url: String?
    var subtitle: String?
    var id: Int?
    var created_at: Int?
    var title: String?
    var cover_image_url: String?
    var updated_at: Int?
    var posts_count: Int?
    
    
     init(dict: [String : AnyObject]) {
        super.init()
        
        status = dict["status"] as? Int
        banner_image_url = dict["banner_image_url"] as? String
        subtitle = dict["subtitle"] as? String
        id = dict["id"] as? Int
        created_at = dict["created_at"] as? Int
        title = dict["title"] as? String
        cover_image_url = dict["cover_image_url"] as? String
        updated_at = dict["updated_at"] as? Int
        posts_count = dict["posts_count"] as?Int
    }
    
}
