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
	
	func getRearSettings(filter: String) -> [RearShock] {
		var bikes : [RearShock] = []
		let fetchRequest = RearShock.rearFetchRequest()
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes
	}
	
	
	func getDualComp(bike: String) -> Bool {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.dualCompression ?? true
	}
	
	func getDualReb(bike: String) -> Bool {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.dualRebound ?? true
	}
	
	func getCoil(bike: String) -> Bool {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.isCoil ?? false
	}
	

	
	
	func getBike(filter: String) -> [Bike] {
		var bikes : [Bike] = []
		let fetchRequest = Bike.bikesFetchRequest()
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes
	}
	
	func getHasRear(bike: String) -> Bool {
		let filteredBike = getBike(filter: bike).filter { bikes in
			bikes.name == bike
		}
		return filteredBike.last?.hasRearShock ?? true
	}
	
	func getTravel(bike: String) -> Double {
		let filteredBike = getBike(filter: bike).filter { bikes in
			bikes.name == bike
		}
		return filteredBike.last?.rearSetup?.strokeLength ?? 0.0
	}
	

	
   
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
    
    @Published var lastRSagSetting: Int16 = 0 {
        didSet {
            didChange.send(self)
        }
    }
       
       @Published var bikeName: String = "" {
           didSet {
               didChange.send(self)
           }
       }
    
        @Published var coil: Bool = true {
            didSet {
                didChange.send(self)
            }
        }
    
        @Published var rComp: Bool = true {
            didSet {
                didChange.send(self)
            }
        }
    
        @Published var rReb: Bool = true {
            didSet {
                didChange.send(self)
            }
        }
    
        @Published var hasRear: Bool = true {
            didSet {
                didChange.send(self)
            }
        }
	
		@Published var travel : Double = 0 {
			didSet {
				didChange.send(self)
			}
		}
	
		@Published var lastRTirePressure: Double = 0.0 {
			didSet {
				didChange.send(self)
			}
		}
	

       let didChange = PassthroughSubject<NoteRearSetupModel, Never>()
       
       // MARK: - Functions
       // get Last Settings
       
       func getLastAir() -> Double {
            let lastRecord = filterNote(for: bikeName)
            let lastAirSetting = lastRecord.last?.rAirSpring
            return lastAirSetting ?? 200.0
       }
	
		func getLastTirePSI() -> Double {
			let lastRecord = filterNote(for: bikeName)
			let lastPSI = lastRecord.last?.rTirePressure
			return lastPSI ?? 0.0
		}
    
    
        func getCoil() -> Bool {
            let lastRecord = filterNote(for: bikeName)
            guard let coil = lastRecord.last?.bike?.rearSetup?.isCoil else { return false }
            return coil
        }
    
        func getRear() -> Bool {
			let last = filterNote(for: bikeName)
			guard let rear = last.last?.bike?.hasRearShock else {return true}
			return rear
        }
       
       func getLastRHSC() -> Int16 {
           let lastRecord = RearSettings.hsc
           return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
       
       func getLastRLSC() -> Int16 {
          let lastRecord = RearSettings.lsc
          return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
       
       func getLastRComp() -> Int16 {
           let lastRecord = RearSettings.compression
           return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
       
       func getLastRHSR() -> Int16 {
           let lastRecord = RearSettings.hsr
           return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
       
       func getLastRLSR() -> Int16 {
           let lastRecord = RearSettings.lsr
           return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
       
       func getLastRRebound() -> Int16 {
           let lastRecord = RearSettings.rebound
           return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
       
       func getLastRTokens() -> Int16 {
           let lastRecord = RearSettings.tokens
           return lastRecord.getSetting(note: filterNote(for: bikeName))
       }
    
		func getLastRSag() -> Int16 {
			let lastRecord = RearSettings.sag
			return lastRecord.getSetting(note: filterNote(for: bikeName))
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
            lastRHSCSetting = getLastRHSC()
            lastRLSCSetting = getLastRLSC()
            lastRCompSetting = getLastRComp()
            lastRHSRSetting = getLastRHSR()
            lastRLSRSetting = getLastRLSR()
            lastRReboundSetting = getLastRRebound()
            lastRTokenSetting = getLastRTokens()
            lastRSagSetting = getLastRSag()
			lastRTirePressure = getLastTirePSI()
            rReb = getDualReb(bike: bikeName)
            rComp = getDualComp(bike: bikeName)
            coil = getCoil(bike: bikeName)
            hasRear = getHasRear(bike: bikeName)
			travel = getTravel(bike: bikeName)
			
       }
	
	func getNoteRearSettings(note: Notes) {
		// Get all the settings and assign
		lastRAirSpringSetting = note.rAirSpring
		lastRHSCSetting = note.rHSC
		lastRLSCSetting = note.rLSC
		lastRCompSetting = note.rCompression
		lastRHSRSetting = note.rHSR
		lastRLSRSetting = note.rLSR
		lastRReboundSetting = note.rRebound
		lastRTokenSetting = note.rTokens
		lastRSagSetting = note.rSag
		lastRTirePressure = note.rTirePressure
		rReb = getDualReb(bike: bikeName)
		rComp = getDualComp(bike: bikeName)
		coil = getCoil(bike: bikeName)
		hasRear = getHasRear(bike: bikeName)
		travel = getTravel(bike: bikeName)
		
	}
	
       func filterNote(for name: String) -> [Notes] {
           let filteredNotes = getNotes().filter { bikes in
               bikes.bike?.name == name
           }
           return filteredNotes
       }
       
       enum RearSettings {
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
                 return note.last?.rCompression ?? 5
             case .hsc:
                 return note.last?.rHSC ?? 8
             case .lsc:
                 return note.last?.rLSC ?? 8
             case .rebound:
                 return note.last?.rRebound ?? 5
             case .hsr:
                 return note.last?.rHSR ?? 8
             case .lsr:
                 return note.last?.rLSR ?? 8
             case .tokens:
                 return note.last?.rTokens ?? 1
             case .sag:
                return note.last?.rSag ?? 25
             }
         }
           
       }
}
