//
//  Bike+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
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
    @NSManaged public var frontSetup: Fork?
    @NSManaged public var rearSetup: RearShock?
    @NSManaged public var setupNotes: NSSet?
    
    public var wrappedBikeName: String {
        name ?? "Unknown Name"
    }
    
    
    //  Convert from an NSSet to Set, convert Set to an Array so that ForEach can read data, then Sort Array (do really need sort if use Ordered?
    public var notesArray: [Notes] {
        let set = setupNotes as? Set<Notes> ?? []
        return set.sorted {
            $0.wrappedNote < $1.wrappedNote
        }
    }

}

// MARK: Generated accessors for setupNotes
extension Bike {

    @objc(addSetupNotesObject:)
    @NSManaged public func addToSetupNotes(_ value: Notes)

    @objc(removeSetupNotesObject:)
    @NSManaged public func removeFromSetupNotes(_ value: Notes)

    @objc(addSetupNotes:)
    @NSManaged public func addToSetupNotes(_ values: NSSet)

    @objc(removeSetupNotes:)
    @NSManaged public func removeFromSetupNotes(_ values: NSSet)

}
