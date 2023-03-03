//
//  PlayerDataEntity+CoreDataProperties.swift
//  
//
//  Created by bjit on 21/2/23.
//
//

import Foundation
import CoreData


extension PlayerDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerDataEntity> {
        return NSFetchRequest<PlayerDataEntity>(entityName: "PlayerDataEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var fullName: String?
    @NSManaged public var imagePath: String?

}
