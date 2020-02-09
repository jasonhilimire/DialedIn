//
//  Fork+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Fork {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fork> {
        return NSFetchRequest<Fork>(entityName: "Fork")
    }

    @NSManaged public var dualCompression: Bool
    @NSManaged public var dualRebound: Bool
    @NSManaged public var lasfFullService: Date?
    @NSManaged public var lowCompression: Int16
    @NSManaged public var lowerLastServiced: Date?
    @NSManaged public var info: String?
    @NSManaged public var bike: Bike?
    
    public var wrappedForkInfo: String {
        info ?? "Unknown Info"
    }

}
