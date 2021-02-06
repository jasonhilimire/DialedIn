//
//  CoreData Extensions.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/11/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import CoreData


//MARK: Extension Fetch Requests
extension Bike{
    
    /// FetchRequest for all bikes, sorted by name
    static func bikesFetchRequest() -> NSFetchRequest<Bike> {
        let request: NSFetchRequest<Bike> = Bike.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Bike.name, ascending: true)]
        return request
    }
    
    /// FetchRequest for selected bike, sorted by name
    static func selectedBikeFetchRequest(filter: String) -> NSFetchRequest<Bike> {
        let request: NSFetchRequest<Bike> = Bike.bikesFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Bike.name, ascending: true)]
        request.predicate = NSPredicate(format: "name == %@", filter)
		request.fetchLimit = 1
        return request
    }    
}

extension Notes{
    static func notesFetchRequest() -> NSFetchRequest<Notes> {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: false)]
        return request
    }
    

    static func Last5NotesFetchRequest(filter: String) -> NSFetchRequest<Notes> {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: false)]
        request.predicate = NSPredicate(format: "%K = %@", "bike.name", filter)
		request.fetchLimit = 5
        return request
    }
	
	static func NoteByIDFetchRequest(filter: UUID) -> NSFetchRequest<Notes> {
		let request: NSFetchRequest<Notes> = Notes.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: false)]
		request.predicate = NSPredicate(format: "id = %@", filter as CVarArg)
		request.fetchLimit = 1
		return request
	}
	
	
	// Fetch the last note regardless of bike
	static func LastNoteFetchRequest() -> NSFetchRequest<Notes> {
		let request: NSFetchRequest<Notes> = Notes.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: false)]
		request.fetchLimit = 1
		return request
	}
	
	// Find favorite notes based on bool set
	static func favoritedNotesFetchRequest(filter: Bool) -> NSFetchRequest<Notes> {
		let request: NSFetchRequest<Notes> = Notes.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: false)]
		if filter == true {
			request.predicate = NSPredicate(format: "isFavorite == TRUE")
		} else {
			request.predicate = NSPredicate(format: "isFavorite == NIL OR isFavorite == TRUE OR isFavorite == FALSE")
		}
//		request.fetchLimit = 1
		return request
	}


}

extension RearService {
	/// FetchRequest for all rear, sorted by name
	static func rearServiceFetchRequest() -> NSFetchRequest<RearService> {
		let request: NSFetchRequest<RearService> = RearService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \RearService.service?.bike?.name, ascending: true)]
		return request
	}
	
	// Last Rear Service regardless of bike
	static func lastRearServiceFetchRequest() -> NSFetchRequest<RearService> {
		let request: NSFetchRequest<RearService> = RearService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \RearService.service?.bike?.name, ascending: false)]
		request.fetchLimit = 1
		return request
	}
	
	
	
}

extension FrontService {
	/// FetchRequest for all frontservice, sorted by name
	static func frontServiceFetchRequest() -> NSFetchRequest<FrontService> {
		let request: NSFetchRequest<FrontService> = FrontService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \FrontService.service?.bike?.name, ascending: true)]
		return request
	}
	
	// Last full Service regardless of bike
	static func lastFrontFullServiceFetchRequest() -> NSFetchRequest<FrontService> {
		let request: NSFetchRequest<FrontService> = FrontService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \FrontService.fullService, ascending: false)]
		request.fetchLimit = 1
		return request
	}
	
	// Last lowers Service regardless of bike
	static func lastFrontLowerServiceFetchRequest() -> NSFetchRequest<FrontService> {
		let request: NSFetchRequest<FrontService> = FrontService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \FrontService.lowersService, ascending: false)]
		request.fetchLimit = 1
		return request
	}
	
	// fetch only lowers
	static func frontServiceLowersFetchRequest(filter: String) -> NSFetchRequest<FrontService> {
		let request: NSFetchRequest<FrontService> = FrontService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \FrontService.lowersService, ascending: true)]
		return request
	}
}

extension Fork {
	/// FetchRequest for all forks, sorted by bike name
	static func forkFetchRequest() -> NSFetchRequest<Fork> {
		let request: NSFetchRequest<Fork> = Fork.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Fork.bike?.name, ascending: true)]
		return request
	}
}

extension RearShock {
	/// FetchRequest for all rear, sorted by bike name
	static func rearFetchRequest() -> NSFetchRequest<RearShock> {
		let request: NSFetchRequest<RearShock> = RearShock.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \RearShock.bike?.name, ascending: true)]
		return request
	}
}




