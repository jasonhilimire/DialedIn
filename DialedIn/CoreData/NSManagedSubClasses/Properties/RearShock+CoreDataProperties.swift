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
	@NSManaged public var strokeLength: Double
    @NSManaged public var bike: Bike?
    @NSManaged public var rearService: NSSet?
	@NSManaged public var id: UUID
	
	
	public var wrappedRearInfo: String {
		info ?? "Unknown Info"
	}


}

// MARK: Generated accessors for rearService
extension RearShock {

    @objc(addRearServiceObject:)
    @NSManaged public func addToRearService(_ value: RearService)

    @objc(removeRearServiceObject:)
    @NSManaged public func removeFromRearService(_ value: RearService)

    @objc(addRearService:)
    @NSManaged public func addToRearService(_ values: NSSet)

    @objc(removeRearService:)
    @NSManaged public func removeFromRearService(_ values: NSSet)

}
