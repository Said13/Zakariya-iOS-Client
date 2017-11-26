//
//  Post.swift
//  Wathakkir
//
//  Created by Abdullah on 19.11.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import ObjectMapper

class Post : Mappable{

    var id: Int?
    var title: String?
    var body: String?
    var link: String?

    required init?(map: Map) {
        
    }

    init(id: Int, title: String, body: String, link: String ) {
        self.id = id
        self.title = title
        self.body = body
        self.link = link
    }

    // Mark : Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        link <- map["link"]
    }
}




