//
//  CoreData Extensions.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/11/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import CoreData


//MARK: Extension Bike
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
        return request
    }
    
} //end Extension Bike

extension Notes{
    static func notesFetchRequest() -> NSFetchRequest<Notes> {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: true)]
        return request
    }
    
    //TODO: Dont think this will work for fetching bikes as it would be a subquery
    static func filteredNotesFetchRequest(filter: String) -> NSFetchRequest<Notes> {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: true)]
        request.predicate = NSPredicate(format: "", filter)
        return request
    }

}

extension RearService {
	/// FetchRequest for all rear, sorted by name
	static func rearFetchRequest() -> NSFetchRequest<RearService> {
		let request: NSFetchRequest<RearService> = RearService.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \RearService.service?.bike?.name, ascending: true)]
		return request
	}
}

