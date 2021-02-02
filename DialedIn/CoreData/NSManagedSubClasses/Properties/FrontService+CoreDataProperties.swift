//
//  FrontService+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension FrontService {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FrontService> {
        return NSFetchRequest<FrontService>(entityName: "FrontService")
    }

    @NSManaged public var fullService: Date?
    @NSManaged public var lowersService: Date?
    @NSManaged public var serviceNote: String?
    @NSManaged public var service: Fork?
	@NSManaged public var id: UUID

	public var wrapped_forkServiceNote: String {
		serviceNote ?? ""
	}
}
