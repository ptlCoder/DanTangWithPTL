//
//  PTLClassDes.swift
//  DanTang(Swift4)
//
//  Created by soliloquy on 2017/10/11.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

import UIKit

class PTLClassDes: NSObject {

    var content_url: String?
    var cover_image_url: String?
    var created_at: String?
    var id: Int?
    var liked: Int?
    var likes_count: Int?
    var published_at: String?
    var share_msg: String?
    var short_title: String?
    var status: Int?
    var title: String?
    var updated_at: String?
    var url: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        
        content_url = dict["content_url"] as? String
        cover_image_url = dict["cover_image_url"] as? String
        created_at = dict["created_at"] as? String
        id = dict["id"] as? Int
        liked = dict["liked"] as? Int
        likes_count = dict["likes_count"] as? Int
        published_at = dict["published_at"] as? String
        share_msg = dict["share_msg"] as? String
        short_title = dict["short_title"] as? String
        status = dict["status"] as? Int
        title = dict["title"] as? String
        updated_at = dict["updated_at"] as? String
        url = dict["url"] as? String
    }
}
