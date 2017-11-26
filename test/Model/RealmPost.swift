//
//  RealmPost.swift
//  Wathakkir
//
//  Created by Abdullah on 22.11.17.
//  Copyright © 2017 Abdullah. All rights reserved.
//

import Foundation
import RealmSwift


// Post model
class RealmPost: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var link: String = ""
    @objc dynamic var date_added = Date(timeIntervalSince1970: 1)
    
    override var description: String { return "Person {\(id), \(title), \(date_added)}" }
    

}
