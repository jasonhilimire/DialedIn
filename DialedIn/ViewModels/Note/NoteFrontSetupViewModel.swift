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

class NoteFrontSetupViewModel: ObservableObject {
    
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	init() {
        getLastFrontSettings()
    }
    
    // MARK: - Published Variables
    @Published var lastFAirSetting: Double = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var lastFAirSetting2: Double = 0 {
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
    
    @Published var lastFSagSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var bikeName: String = "" {
        didSet {
            didChange.send(self)
        }
    }
	
	@Published var lastFTirePressure: Double = 0 {
		didSet {
			didChange.send(self)
		}
	}

	    
    let didChange = PassthroughSubject<NoteFrontSetupViewModel, Never>()
    
    // MARK: - Functions
    // get Last Settings
	
    
    func getLastAir() -> Double {
        let lastRecord = filterBikes(for: bikeName)
        let lastAirSetting = lastRecord.last?.fAirVolume
        return lastAirSetting ?? 65.0
    }
    
    func getLastAir2() -> Double {
        let lastRecord = filterBikes(for: bikeName)
        let lastAirSetting = lastRecord.last?.fAirVolume2
        return lastAirSetting ?? 65.0
    }
    
    
    func getAirforBikeCard(bike: String) -> Double {
        let lastRecord = filterBikes(for: bike)
        let lastAirSetting = lastRecord.last?.fAirVolume
        return lastAirSetting ?? 00.0
    }

    func getAir2forBikeCard(bike: String) -> Double {
        let lastRecord = filterBikes(for: bike)
        let lastAirSetting = lastRecord.last?.fAirVolume2
        return lastAirSetting ?? 00.0
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
    
    func getLastFSag() -> Int16 {
        let lastRecord = FrontSettings.sag
        return lastRecord.getSetting(note: filterBikes(for: bikeName))
    }
	
	func getLastTirePSI() -> Double {
		let lastRecord = filterBikes(for: bikeName)
		let last = lastRecord.last?.fTirePressure
		return last ?? 0.0
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
        lastFAirSetting2 = getLastAir2()
        lastFHSCSetting = getLastFHSC()
        lastFLSCSetting = getLastFLSC()
        lastFCompSetting = getLastFComp()
        lastFHSRSetting = getLastFHSR()
        lastFLSRSetting = getLastFLSR()
        lastFReboundSetting = getLastFRebound()
        lastFTokenSetting = getLastFTokens()
        lastFSagSetting = getLastFSag()
		lastFTirePressure = getLastTirePSI()
    }
	
 // THIS WORKS Now need to figure out how to pass the selected bike into the Model from the pickerview
    func filterBikes(for name: String) -> [Notes] {
        let filteredBikes = getNotes().filter { bikes in
            bikes.bike?.name == name
        }
        return filteredBikes
    }
	
	// Not being used for anything but example on how to fetch by UUID
	func getNoteByID(for noteID: UUID) -> Notes  {
		let notes = try! managedObjectContext.fetch(Notes.NoteByIDFetchRequest(filter: noteID))
		if let note = notes.first {
			return note
		} else {
			return notes[0]
		}
	}
	
	func filter(for name: String) -> [Bike] {
		let filteredBikes = getBikes().filter { bikes in
			bikes.name == name
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
        case sag
	
        func getSetting(note: [Notes]) -> Int16 {
            // if no filteredBike is found sets all values to 0
          switch self {
          case .compression:
              return note.last?.fCompression ?? 5
          case .hsc:
              return note.last?.fHSC ?? 8
          case .lsc:
              return note.last?.fLSC ?? 8
          case .rebound:
              return note.last?.fRebound ?? 5
          case .hsr:
              return note.last?.fHSR ?? 8
          case .lsr:
              return note.last?.fLSR ?? 8
          case .tokens:
              return note.last?.fTokens ?? 1
          case .sag:
            return note.last?.fSag ?? 25
            
          }
      }
        
    }
    
}
