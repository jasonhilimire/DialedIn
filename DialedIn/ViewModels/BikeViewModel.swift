//
//  BikeViewModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BikeViewModel: ObservableObject {
    
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	var rearSetupIndex = 1
	var rearSetups = ["None", "Air", "Coil"]
	var duplicateNameAlert = false
    
    
    init() {
//        getLastBike()
    }
	
//	var id: UUID
    
	@Published var bikeName: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var bikeNote: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var isDefault: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var hasRearShock: Bool = true {
		didSet {
			didChange.send(self)
		}
	}
    
    let didChange = PassthroughSubject<BikeViewModel, Never>()

	func getBikes() -> [Bike] {
		let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
		return bikes
	}
	
	func filterBikes(for name: String) -> [Bike] {
		let filteredBike = try! managedObjectContext.fetch(Bike.selectedBikeFetchRequest(filter: name))
		return filteredBike
	}
	
//TODO: REFACTOR to incluce forName: String into each below & getBike
	func getRear() -> Bool {
		let last = filterBikes(for: bikeName ?? "")
		guard let rear = last.last?.hasRearShock else {return true}
		return rear
	}
	
	func getDefault() -> Bool {
		let last = filterBikes(for: bikeName ?? "")
		guard let rear = last.last?.isDefault else {return false}
		return rear
	}
	
	
	func getNote() -> String {
		let last = filterBikes(for: bikeName ?? "")
		guard let rear = last.last?.bikeNote else {return ""}
		return rear
	}
	
    func getBike() {
//TODO: Add BikeName here?? 
        bikeNote = getNote()
		hasRearShock = getRear()
		isDefault = getDefault()
    }
	
	func saveNewBike(fork: Fork, rearShock: RearShock) {
		let newBike = Bike(context: managedObjectContext)
		
		newBike.id = UUID()
		newBike.name = self.bikeName
		newBike.bikeNote = self.bikeNote
		newBike.isDefault = self.isDefault
		newBike.hasRearShock = self.hasRearShock
		
		newBike.frontSetup = fork
		newBike.rearSetup = rearShock

		// - Rear Creation based on Index -
		if self.rearSetupIndex == 1 { //AirShock
			// set coil to false
			newBike.hasRearShock = true
		} else if self.rearSetupIndex == 2 { //CoilShock
			// set coil to false
			newBike.hasRearShock = true
			newBike.rearSetup?.isCoil = false

		} else if self.rearSetupIndex == 0 { // No Shock
			// set coil to true
			newBike.hasRearShock = false
			newBike.rearSetup?.isCoil = true
		}
		
		try? self.managedObjectContext.save()
	}
	
	func updateBike(bike: Bike, fork: Fork, rearShock: RearShock) {
		managedObjectContext.performAndWait {
			bike.name = self.bikeName
			bike.bikeNote = self.bikeNote
			bike.isDefault = self.isDefault
			bike.hasRearShock = self.hasRearShock
			
			bike.frontSetup = fork
			bike.rearSetup = rearShock
			
			// - Rear Creation based on Index -
			if self.rearSetupIndex == 1 { //AirShock
				// set coil to false
				bike.hasRearShock = true
			} else if self.rearSetupIndex == 2 { //CoilShock
				// set coil to false
				bike.hasRearShock = true
				bike.rearSetup?.isCoil = false
				
			} else if self.rearSetupIndex == 0 { // No Shock
				// set coil to true
				bike.hasRearShock = false
				bike.rearSetup?.isCoil = true
			}
			if self.managedObjectContext.hasChanges {
				try? self.managedObjectContext.save()
			}
		}
		
		
	}
	
	
	func checkBikeNameExists() {
		let filteredBikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
		for bike in filteredBikes {
			if bike.name?.lowercased() == bikeName!.lowercased() {
				duplicateNameAlert.toggle()
				break
			}
		}
	}

}


// PRIOR SAVE NEW BIKE
/*
{
// start at the child and work way up with creating Entities
/// Setup
let newRearService = RearService(context: self.moc)
newRearService.service = RearShock(context: self.moc)
let newRearShock = newRearService.service
newRearService.service?.bike = Bike(context: self.moc)
let newFrontService = FrontService(context: self.moc)
newFrontService.service = Fork(context: self.moc)
let newFork = newFrontService.service
let newBike = newRearService.service?.bike
let dateString = dateFormatter.string(from: Date())


// - Bike Creation

newBike?.name = self.bikeName // function check here
newBike?.bikeNote = self.bikeNote
newBike?.isDefault = self.setDefault
newBike?.id = UUID()

// - Front Creation
newFrontService.service?.bike = newBike
newFork?.travel = Double(self.forkTravel) ?? 0.0
newFork?.dualCompression = self.forkDualCompToggle
newFork?.dualRebound = self.forkDualReboundToggle
if self.forkInfo == "" {
newFork?.info = "Fork"
} else {
newFork?.info = self.forkInfo
}
newFork?.id = UUID()
newFrontService.lowersService = self.lastLowerServiceDate
newFrontService.fullService = self.lastFullForkServiceDate
newFrontService.serviceNote = "Bike Created: \(dateString), no services found yet"
newFrontService.id = UUID()


// - Rear Creation -


if self.rearSetupIndex == 1 {
newBike?.hasRearShock = true
if rearInfo == "" {
newRearShock?.info = "Rear Shock"
} else {
newRearShock?.info = self.rearInfo
}
newRearShock?.strokeLength = Double(self.strokeLength) ?? 0.0
newRearShock?.rearTravel = Double(self.rearTravel) ?? 0.0
newRearShock?.dualCompression = self.rearDualCompToggle
newRearShock?.dualRebound = self.rearDualCompToggle
newRearShock?.isCoil = self.isCoilToggle
newRearService.airCanService = self.lastAirCanServiceDate
newRearService.fullService = self.lastRearFullServiceDate

newRearService.serviceNote = "Bike Created: \(dateString), no services found yet"
newRearShock?.id = UUID()
newRearService.id = UUID()

} else if self.rearSetupIndex == 2 {
self.isCoilToggle.toggle()

newBike?.hasRearShock = true
if rearInfo == "" {
newRearShock?.info = "Rear Shock"
} else {
newRearShock?.info = self.rearInfo
}
newRearShock?.strokeLength = Double(self.strokeLength) ?? 0.0
newRearShock?.rearTravel = Double(self.rearTravel) ?? 0.0
newRearShock?.dualCompression = self.rearDualCompToggle
newRearShock?.dualRebound = self.rearDualCompToggle
newRearShock?.isCoil = self.isCoilToggle
newRearService.airCanService = self.lastAirCanServiceDate
newRearService.fullService = self.lastRearFullServiceDate
newRearService.serviceNote = "Bike Created: \(dateString), no services found yet"
newRearShock?.id = UUID()
newRearService.id = UUID()

} else if self.rearSetupIndex == 0 {
newBike?.hasRearShock = false
newRearShock?.isCoil = false
newRearShock?.id = UUID()
newRearService.id = UUID()
}

}
*/
