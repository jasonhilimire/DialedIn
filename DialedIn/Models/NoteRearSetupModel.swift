//
//  NoteRearSetupModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/17/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NoteRearSetupModel: ObservableObject {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
       init() {
           getLastRearSettings()
       }
       
       // MARK: - Published Variables
       @Published var lastRAirSpringSetting: Double = 0 {
           didSet {
               didChange.send(self)
           }
       }

       @Published var lastRCompSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var lastRHSCSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var lastRLSCSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var lastRReboundSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var lastRHSRSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var lastRLSRSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var lastRTokenSetting: Int16 = 0 {
           didSet {
               didChange.send(self)
           }
       }
       
       @Published var bikeName: String = "" {
           didSet {
               didChange.send(self)
           }
       }
       
       
       let didChange = PassthroughSubject<NoteRearSetupModel, Never>()
       
       // MARK: - Functions
       // get Last Settings
       
       func getLastAir() -> Double {
           let lastRecord = filterBikes(for: bikeName)
        let lastAirSetting = lastRecord.last?.rAirSpring
           return lastAirSetting ?? 200.0
       }
       
       func getLastFHSC() -> Int16 {
           let lastRecord = RearSettings.hsc
           return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
       
       func getLastFLSC() -> Int16 {
          let lastRecord = RearSettings.lsc
          return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
       
       func getLastFComp() -> Int16 {
           let lastRecord = RearSettings.compression
           return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
       
       func getLastFHSR() -> Int16 {
           let lastRecord = RearSettings.hsr
           return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
       
       func getLastFLSR() -> Int16 {
           let lastRecord = RearSettings.lsr
           return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
       
       func getLastFRebound() -> Int16 {
           let lastRecord = RearSettings.rebound
           return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
       
       func getLastFTokens() -> Int16 {
           let lastRecord = RearSettings.tokens
           return lastRecord.getSetting(note: filterBikes(for: bikeName))
       }
           
       func getNotes() -> [Notes] {
           let notes = try! managedObjectContext.fetch(Notes.fetchRequest()) as! [Notes]
           return notes
       }
       
       func getBikes() -> [Bike] {
           let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
           return bikes
       }
       
       func getLastRearSettings() {
           // Get all the settings and assign
           lastRAirSpringSetting = getLastAir()
           lastRHSCSetting = getLastFHSC()
           lastRLSCSetting = getLastFLSC()
           lastRCompSetting = getLastFComp()
           lastRHSRSetting = getLastFHSR()
           lastRLSRSetting = getLastFLSR()
           lastRReboundSetting = getLastFRebound()
           lastRTokenSetting = getLastFTokens()
       }
       
    // THIS WORKS Now need to figure out how to pass the selected bike into the Model from the pickerview
       func filterBikes(for name: String) -> [Notes] {
           let filteredBikes = getNotes().filter { bikes in
               bikes.bike?.name == name
           }
           return filteredBikes
       }
       
       enum RearSettings {
           case compression
           case hsc
           case lsc
           case rebound
           case hsr
           case lsr
           case tokens
           
           func getSetting(note: [Notes]) -> Int16 {
               // if no filteredBike is found sets all values to 0
             switch self {
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
