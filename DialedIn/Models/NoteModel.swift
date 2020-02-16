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
    @State private var bikeNameIndex = 0
    
    init() {
        getLastFSettings(bikeIndex: 0)
    }
    
    // MARK: - Published Variables
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
    
    @Published var lastFLSCSetting: Int = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFTokenSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    
    
    let didChange = PassthroughSubject<NoteModel, Never>()
    
    // MARK: - Functions

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
        if getNotes().count > 0 {
            let lastRecord = getNotes().last?.fHSC
            print("Last HSC = \(String(describing: lastRecord))")
            return Int(lastRecord!)
        }
        return 8
    }
    
    func getLastFLSC(for chosenBike: Int) -> Int {
        // get ALL the bikes
        let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
        // filter the records for the chosen bike
        let bike = bikes[chosenBike].name
        if filterBikes(for: bike!).count > 0 {
            let lastRecord = filterBikes(for: bike!)
            print(lastRecord.last)
            let lsc = lastRecord.last?.fLSC
            print("Last LSC = \(String(describing: lsc))")
            return Int(lsc!)
        }
        return 8
    }
    
    
    func getLastFTokens() -> Int16 {
        let lastRecord = FrontSettings.tokens
        print("Last Tokens = \(String(describing: lastRecord))")
        return lastRecord.getSetting(note: getNotes())
    }
        
    func getNotes() -> [Notes] {
        let notes = try! managedObjectContext.fetch(Notes.fetchRequest()) as! [Notes]
        return notes
    }
    
    func getBikes() -> [Bike] {
        let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
        return bikes
    }
    
    func getLastFSettings(bikeIndex: Int) {
        lastFAirSetting = lastAir
        lastFHSCSetting = getLastFHSC()
        lastFLSCSetting = getLastFLSC(for: bikeIndex)
        lastFTokenSetting = getLastFTokens()
    }
    
    func filterBikes(for name: String) -> [Notes] {
        let filteredBikes = getNotes().filter { bikes in
            bikes.bike?.name == name
        }
        return filteredBikes
    }
    
    enum FrontSettings {
//        case airVolume
        case compression
        case hsc
        case lsc
        case rebound
        case hsr
        case lsr
        case tokens
        
        func getSetting(note: [Notes]) -> Int16 {
          switch self {
//          case .airVolume:
//              return note.last?.fAirVolume ?? 55.0
          case .compression:
              return note.last?.fCompression ?? 0
          case .hsc:
              return note.last?.fHSC ?? 0
          case .lsc:
              return note.last?.fLSC ?? 0
          case .rebound:
              return note.last?.fRebound ?? 0
          case .hsr:
              return note.last?.fHSR ?? 0
          case .lsr:
              return note.last?.fLSR ?? 0
          case .tokens:
              return note.last?.fTokens ?? 0
          }
      }
        
    }
    
}
