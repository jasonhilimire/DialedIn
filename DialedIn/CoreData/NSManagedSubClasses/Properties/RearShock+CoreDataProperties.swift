//
//  RearShock+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension RearShock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RearShock> {
        return NSFetchRequest<RearShock>(entityName: "RearShock")
    }

    @NSManaged public var dualCompression: Bool
    @NSManaged public var dualRebound: Bool
    @NSManaged public var info: String?
    @NSManaged public var isCoil: Bool
    @NSManaged public var lastAirCanService: Date?
    @NSManaged public var lastFullService: Date?
    @NSManaged public var bike: Bike?
    @NSManaged public var rearService: NSOrderedSet?
	
	public var wrappedRearInfo: String {
		info ?? "Unknown Info"
	}

}

// MARK: Generated accessors for rearService
extension RearShock {

    @objc(insertObject:inRearServiceAtIndex:)
    @NSManaged public func insertIntoRearService(_ value: RearService, at idx: Int)

    @objc(removeObjectFromRearServiceAtIndex:)
    @NSManaged public func removeFromRearService(at idx: Int)

    @objc(insertRearService:atIndexes:)
    @NSManaged public func insertIntoRearService(_ values: [RearService], at indexes: NSIndexSet)

    @objc(removeRearServiceAtIndexes:)
    @NSManaged public func removeFromRearService(at indexes: NSIndexSet)

    @objc(replaceObjectInRearServiceAtIndex:withObject:)
    @NSManaged public func replaceRearService(at idx: Int, with value: RearService)

    @objc(replaceRearServiceAtIndexes:withRearService:)
    @NSManaged public func replaceRearService(at indexes: NSIndexSet, with values: [RearService])

    @objc(addRearServiceObject:)
    @NSManaged public func addToRearService(_ value: RearService)

    @objc(removeRearServiceObject:)
    @NSManaged public func removeFromRearService(_ value: RearService)

    @objc(addRearService:)
    @NSManaged public func addToRearService(_ values: NSOrderedSet)

    @objc(removeRearService:)
    @NSManaged public func removeFromRearService(_ values: NSOrderedSet)

}
