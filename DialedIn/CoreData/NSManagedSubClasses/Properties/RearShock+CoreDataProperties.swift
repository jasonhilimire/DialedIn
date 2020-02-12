//
//  RearShock+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
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
    @NSManaged public var isCoil: Bool
    @NSManaged public var lastAirCanService: Date?
    @NSManaged public var lastFullService: Date?
    @NSManaged public var info: String?
    @NSManaged public var bike: Bike?
    
    public var wrappedRearInfo: String {
        info ?? "Unknown Info"
    }

}
