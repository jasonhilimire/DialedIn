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

class NoteFrontSetupModel: ObservableObject {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    init() {
        getLastFrontSettings()
    }
    
    // MARK: - Published Variables
    @Published var lastFAirSetting: Double = 0 {
        didSet {
            didChange.send(self)
        }
    }

    @Published var lastFCompSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFHSCSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFLSCSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFReboundSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFHSRSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFLSRSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFTokenSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var bikeName: String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
// TODO: refactor these fork settings into own Model
    @Published var fComp: Bool = true {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var fReb: Bool = true {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<NoteFrontSetupModel, Never>()
    
    // MARK: - Functions
    // get Last Settings
    
    func getLastAir() -> Double {
        let lastRecord = filterBikes(for: bikeName)
        let lastAirSetting = lastRecord.last?.fAirVolume
        return lastAirSetting ?? 60.0
    }
    
    func getfComp() -> Bool {
        let lastRecord = filterBikes(for: bikeName)
        guard let comp = lastRecord.last?.bike?.frontSetup?.dualCompression else { return true }
        return comp
    }
    func getfReb() -> Bool {
        let lastRecord = filterBikes(for: bikeName)
        guard let rebound = lastRecord.last?.bike?.frontSetup?.dualRebound else { return true }
        return rebound
    }
    
    func getLastFHSC() -> Int16 {
        let lastRecord = FrontSettings.hsc
        return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
    
    func getLastFLSC() -> Int16 {
       let lastRecord = FrontSettings.lsc
       return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
    
    func getLastFComp() -> Int16 {
        let lastRecord = FrontSettings.compression
        return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
    
    func getLastFHSR() -> Int16 {
        let lastRecord = FrontSettings.hsr
        return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
    
    func getLastFLSR() -> Int16 {
        let lastRecord = FrontSettings.lsr
        return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
    
    func getLastFRebound() -> Int16 {
        let lastRecord = FrontSettings.rebound
        return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
    
    func getLastFTokens() -> Int16 {
        let lastRecord = FrontSettings.tokens
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
    
    func getLastFrontSettings() {
        // Get all the settings and assign
        lastFAirSetting = getLastAir()
        lastFHSCSetting = getLastFHSC()
        lastFLSCSetting = getLastFLSC()
        lastFCompSetting = getLastFComp()
        lastFHSRSetting = getLastFHSR()
        lastFLSRSetting = getLastFLSR()
        lastFReboundSetting = getLastFRebound()
        lastFTokenSetting = getLastFTokens()
        fComp = getfComp()
        fReb = getfReb()
    }
    
 // THIS WORKS Now need to figure out how to pass the selected bike into the Model from the pickerview
    func filterBikes(for name: String) -> [Notes] {
        let filteredBikes = getNotes().filter { bikes in
            bikes.bike?.name == name
        }
        return filteredBikes
    }
    
    enum FrontSettings {
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
