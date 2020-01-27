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

    @NSManaged public var airVolume: Double
    @NSManaged public var compression: Int16
    @NSManaged public var dualCompression: Bool
    @NSManaged public var dualRebound: Bool
    @NSManaged public var highCompression: Int16
    @NSManaged public var highRebound: Int16
    @NSManaged public var isCoil: Bool
    @NSManaged public var lastAirCanService: Date?
    @NSManaged public var lastFullService: Date?
    @NSManaged public var lowCompression: Int16
    @NSManaged public var lowRebound: Int16
    @NSManaged public var rebound: Int16
    @NSManaged public var spring: Int16
    @NSManaged public var tokens: Int16
    @NSManaged public var bike: Bike?

}
