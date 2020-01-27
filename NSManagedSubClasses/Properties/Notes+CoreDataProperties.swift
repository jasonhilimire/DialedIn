//
//  Notes+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var rating: Int16?
    @NSManaged public var bike: Bike?
    
    public var wrappedBike: String {
        bike ?? "Unknown Bike"
    }
    
    public var wrappedNote String {
        note ?? "Unknown Note"
    }

}
