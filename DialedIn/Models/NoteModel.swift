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
        getLastfHSC()
    }
    
    @Published var lastFAirSetting: Double = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFHSCSetting: Int = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    
    
    let didChange = PassthroughSubject<NoteModel, Never>()

    //Should this be changed to reflect the Bike.Note
    private var lastAir: Double  {
        let notes = try! managedObjectContext.fetch(Notes.notesFetchRequest())
        if let lastRecord = notes.last {
            let lastfAirNote = lastRecord.value(forKey: "fAirVolume")
            print("Last Air setting was \(String(describing: lastfAirNote))")
                   return lastfAirNote as! Double
               } else {
                   print("didnt find last record")
            return 55.0
               }
       }
    
    
    private var lastHSC: Int {
        let notes = try! managedObjectContext.fetch(Notes.notesFetchRequest())
        if let lastRecord = notes.last {
         let lastfHSC = lastRecord.value(forKey: "fHSC")
            print("Last Air setting was \(String(describing: lastfHSC))")
                   return lastfHSC as! Int
               } else {
                   print("didnt find last HSC record")
            return 8
               }
    }
    
    func getNotes() -> [Notes] {
        let notes = try! managedObjectContext.fetch(Notes.notesFetchRequest())
        return notes
    }
    
    func getLastfAirSetting() {
        lastFAirSetting = lastAir
    }
    
    func getLastfHSC() {
        lastFHSCSetting = lastHSC
    }
    

    
}
