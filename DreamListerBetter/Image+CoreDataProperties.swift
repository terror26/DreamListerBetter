//
//  Image+CoreDataProperties.swift
//  DreamListerBetter
//
//  Created by Bhawna Verma on 21/05/1939 Saka.
//  Copyright © 1939 Saka Bhawna Verma. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var tostore: NSSet?
    @NSManaged public var toitem: Item?

}

// MARK: Generated accessors for tostore
extension Image {

    @objc(addTostoreObject:)
    @NSManaged public func addToTostore(_ value: Store)

    @objc(removeTostoreObject:)
    @NSManaged public func removeFromTostore(_ value: Store)

    @objc(addTostore:)
    @NSManaged public func addToTostore(_ values: NSSet)

    @objc(removeTostore:)
    @NSManaged public func removeFromTostore(_ values: NSSet)

}
