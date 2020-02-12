//
//  NoteModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NoteModel: ObservableObject {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        getLastfAirSetting()
    }
    
    @Published var lastFAirSetting: Int = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<NoteModel, Never>()

    private var lastAir: Int  {
        let notes = try! managedObjectContext.fetch(Notes.fetchRequest()) as! [Notes]
        if let lastRecord = notes.last {
            let lastfAirNote = lastRecord.value(forKey: "fAirVolume")
            print("Last Air setting was \(String(describing: lastfAirNote))")
                   return lastfAirNote as! Int
               } else {
                   print("didnt find last record")
                   return 55
               }
       }
    
    func getLastfAirSetting() {
        lastFAirSetting = lastAir
    }
    
}
