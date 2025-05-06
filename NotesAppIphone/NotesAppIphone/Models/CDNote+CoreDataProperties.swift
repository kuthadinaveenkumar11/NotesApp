//
//  CDNote+CoreDataProperties.swift
//  NotesAppIphone
//
//  Created by Rakesh Yelakanti on 05/05/25.
//
//

import Foundation
import CoreData


extension CDNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNote> {
        return NSFetchRequest<CDNote>(entityName: "CDNote")
    }

    @NSManaged public var createdAt: Int64
    @NSManaged public var details: String?
    @NSManaged public var id: String?
    @NSManaged public var isFav: Bool
    @NSManaged public var isSynced: Bool
    @NSManaged public var name: String?
    @NSManaged public var tags: [String]?

}

extension CDNote : Identifiable {

}
