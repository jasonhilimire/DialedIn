//
//  BikeModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BikeModel: ObservableObject {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    init() {
        getLastAirSetting()
    }
    
    @Published var lastAirSetting: Int = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<BikeModel, Never>()

    private var lastAir: Int  {
        let notes = try! managedObjectContext.fetch(Bike.fetchRequest()) as! [Bike]
        if let lastRecord = notes.last {
            let lastRecordNote = lastRecord.value(forKey: "name")
                   return lastRecordNote as! Int
               } else {
                   print("didnt find last record")
                   return 55
               }
       }
    
    func getBike(filter: String) {
        let fetchRequest = FetchRequest<Bike>(entity: Bike.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS %@", filter))
        
        
    }
    
    func getLastAirSetting() {
        lastAirSetting = lastAir
    }
    
}
