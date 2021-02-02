//
//  RearService+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension RearService {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RearService> {
        return NSFetchRequest<RearService>(entityName: "RearService")
    }

    @NSManaged public var airCanService: Date?
    @NSManaged public var fullService: Date?
    @NSManaged public var serviceNote: String?
    @NSManaged public var service: RearShock?
	@NSManaged public var id: UUID
	
	public var wrappedRearServiceNote: String {
		serviceNote ?? ""
	}

}
