//
//  Store+CoreDataProperties.swift
//  DreamListerBetter
//
//  Created by Bhawna Verma on 21/05/1939 Saka.
//  Copyright © 1939 Saka Bhawna Verma. All rights reserved.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var name: String?
    @NSManaged public var toitem: NSSet?
    @NSManaged public var toimage: Image?

}

// MARK: Generated accessors for toitem
extension Store {

    @objc(addToitemObject:)
    @NSManaged public func addToToitem(_ value: Item)

    @objc(removeToitemObject:)
    @NSManaged public func removeFromToitem(_ value: Item)

    @objc(addToitem:)
    @NSManaged public func addToToitem(_ values: NSSet)

    @objc(removeToitem:)
    @NSManaged public func removeFromToitem(_ values: NSSet)

}
