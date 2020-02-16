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
        getLastFSettings()
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
        let notes = try! managedObjectContext.fetch(Notes.fetchRequest()) as! [Notes]
        if let lastRecord = notes.last {
            let lastfAirNote = lastRecord.value(forKey: "fAirVolume")
            print("Last Air setting was \(String(describing: lastfAirNote))")
                   return lastfAirNote as! Double
               } else {
                   print("didnt find last record")
            return 55.0
               }
       }
    
    
        func getLastFHSC() -> Int {
    //        getNotes()
            if getNotes().count > 0 {
                let lastRecord = getNotes().last?.fHSC
                print("Last HSC = \(String(describing: lastRecord))")
                return Int(lastRecord!)
            }
            return 8
      
        }
        
        func getNotes() -> [Notes] {
            let notes = try! managedObjectContext.fetch(Notes.fetchRequest()) as! [Notes]
            return notes
        }
    
    func getLastFSettings() {
        lastFAirSetting = lastAir
        lastFHSCSetting = getLastFHSC()
    }
    
}
