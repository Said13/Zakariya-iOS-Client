//
//  PostCD+CoreDataProperties.swift
//  
//
//  Created by Abdullah on 22.11.17.
//
//

import Foundation
import CoreData


extension PostCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCD> {
        return NSFetchRequest<PostCD>(entityName: "PostCD")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var id: Int16

}
