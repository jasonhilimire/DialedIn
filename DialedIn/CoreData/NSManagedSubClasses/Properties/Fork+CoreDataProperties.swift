//
//  Fork+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 4/18/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Fork {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Fork> {
		return NSFetchRequest<Fork>(entityName: "Fork")
	}
	
	@NSManaged public var id: UUID
	@NSManaged public var dualCompression: Bool
	@NSManaged public var dualRebound: Bool
	@NSManaged public var info: String?
	@NSManaged public var travel: Double
	@NSManaged public var fullServiceWarn: Int16
	@NSManaged public var lowersServiceWarn: Int16
	@NSManaged public var bike: Bike?
	@NSManaged public var frontService: NSSet?
	
	public var wrappedForkInfo: String {
		info ?? "Unknown Info"
	}
	
	//  Convert from an NSSet to Set, convert Set to an Array so that ForEach can read data, then Sort Array (do really need sort if use Ordered?
	public var frontServiceArray: [FrontService] {
		let set = frontService as? Set<FrontService> ?? []
		return set.sorted {
			$0.wrapped_forkServiceNote < $1.wrapped_forkServiceNote
		}
	}
	
}

// MARK: Generated accessors for frontService
extension Fork {
	
	@objc(addFrontServiceObject:)
	@NSManaged public func addToFrontService(_ value: FrontService)
	
	@objc(removeFrontServiceObject:)
	@NSManaged public func removeFromFrontService(_ value: FrontService)
	
	@objc(addFrontService:)
	@NSManaged public func addToFrontService(_ values: NSSet)
	
	@objc(removeFrontService:)
	@NSManaged public func removeFromFrontService(_ values: NSSet)
	
}
