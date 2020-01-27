//
//  Bike+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Bike {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bike> {
        return NSFetchRequest<Bike>(entityName: "Bike")
    }

    @NSManaged public var hasRearShock: Bool
    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var frontSetup: Fork?
    @NSManaged public var rearSetup: RearShock?
    @NSManaged public var setupNotes: NSOrderedSet?

}

// MARK: Generated accessors for setupNotes
extension Bike {

    @objc(insertObject:inSetupNotesAtIndex:)
    @NSManaged public func insertIntoSetupNotes(_ value: Notes, at idx: Int)

    @objc(removeObjectFromSetupNotesAtIndex:)
    @NSManaged public func removeFromSetupNotes(at idx: Int)

    @objc(insertSetupNotes:atIndexes:)
    @NSManaged public func insertIntoSetupNotes(_ values: [Notes], at indexes: NSIndexSet)

    @objc(removeSetupNotesAtIndexes:)
    @NSManaged public func removeFromSetupNotes(at indexes: NSIndexSet)

    @objc(replaceObjectInSetupNotesAtIndex:withObject:)
    @NSManaged public func replaceSetupNotes(at idx: Int, with value: Notes)

    @objc(replaceSetupNotesAtIndexes:withSetupNotes:)
    @NSManaged public func replaceSetupNotes(at indexes: NSIndexSet, with values: [Notes])

    @objc(addSetupNotesObject:)
    @NSManaged public func addToSetupNotes(_ value: Notes)

    @objc(removeSetupNotesObject:)
    @NSManaged public func removeFromSetupNotes(_ value: Notes)

    @objc(addSetupNotes:)
    @NSManaged public func addToSetupNotes(_ values: NSOrderedSet)

    @objc(removeSetupNotes:)
    @NSManaged public func removeFromSetupNotes(_ values: NSOrderedSet)

}
