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
        request.predicate = NSPredicate(format: "name CONTAINS %@", filter)
        return request
    }
    
} //end Extension Bike

extension Notes{
    static func notesFetchRequest() -> NSFetchRequest<Notes> {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: true)]
        return request
    }
    
}

