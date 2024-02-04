//
//  Notes+CoreDataProperties.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

	@NSManaged public var id: UUID
	@NSManaged public var date: Date?
	@NSManaged public var fAirVolume: Double
    @NSManaged public var fAirVolume2: Double
	@NSManaged public var fCompression: Int16
	@NSManaged public var fHSC: Int16
	@NSManaged public var fHSR: Int16
	@NSManaged public var fLSC: Int16
	@NSManaged public var fLSR: Int16
	@NSManaged public var fRebound: Int16
	@NSManaged public var fSag: Int16
	@NSManaged public var fTokens: Int16
	@NSManaged public var isFavorite: Bool
	@NSManaged public var note: String?
	@NSManaged public var rAirSpring: Double
	@NSManaged public var rating: Int16
	@NSManaged public var rCompression: Int16
	@NSManaged public var rHSC: Int16
	@NSManaged public var rHSR: Int16
	@NSManaged public var rLSC: Int16
	@NSManaged public var rLSR: Int16
	@NSManaged public var rRebound: Int16
	@NSManaged public var rSag: Int16
	@NSManaged public var rTokens: Int16
	@NSManaged public var fTirePressure: Double
	@NSManaged public var rTirePressure: Double
	@NSManaged public var bike: Bike?

    public var wrappedNote: String {
        note ?? "Unknown Note"
    }
}
