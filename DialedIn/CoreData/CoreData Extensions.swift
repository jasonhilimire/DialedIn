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
    static func BikesFetchRequest() -> NSFetchRequest<Bike> {
        let request: NSFetchRequest<Bike> = Bike.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Bike.name, ascending: true)]
        return request
    }
    
    /// FetchRequest for selected bike, sorted by name
    static func SelectedBikeFetchRequest(filter: String) -> NSFetchRequest<Bike> {
        let request: NSFetchRequest<Bike> = Bike.BikesFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Bike.name, ascending: true)]
        request.predicate = NSPredicate(format: "name CONTAINS %@", filter)
        return request
    }
    
} //end Extension Bike

extension Notes{
    /// FetchRequest for all notes, sorted by date
    static func notesFetchRequest() -> NSFetchRequest<Notes> {
           let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: true)]
           return request
       }
    
    ///Fetch request for Notes selected by bike
    static func selectedNoteFetchRequest(filter: String) -> NSFetchRequest<Notes> {
        let request: NSFetchRequest<Notes> = Notes.notesFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: true)]
        request.predicate = NSPredicate(format: "name CONTAINS %@", filter)
        return request
    }
}
