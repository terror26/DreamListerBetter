//
//  Item+CoreDataProperties.swift
//  DreamListerBetter
//
//  Created by Bhawna Verma on 21/05/1939 Saka.
//  Copyright © 1939 Saka Bhawna Verma. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var tostore: Store?
    @NSManaged public var toimage: Image?
    @NSManaged public var toitemtype: ItemType?

}
