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
	
	func getName(_ bikeName: String) -> String {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.wrappedBikeName else {return ""}
		return rear
	}
	
	func getRear(_ bikeName: String) -> Bool {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.hasRearShock else {return true}
		return rear
	}
	
	func getDefault(_ bikeName: String) -> Bool {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.isDefault else {return false}
		return rear
	}
	
	
	func getNote(_ bikeName: String) -> String {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.bikeNote else {return ""}
		return rear
	}
	
	func getBike(for name: String) {
		bikeName = getName(name)
		print("getBikeName: \(bikeName)")
        bikeNote = getNote(name)
		hasRearShock = getRear(name)
	
		isDefault = getDefault(name)
    }
	
	func getSetupIndex(bike: Bike) {
		let setupIndex: Int
		if bike.hasRearShock == false {
			setupIndex = 0
		} else if bike.rearSetup?.isCoil == true {
			setupIndex = 2
		} else {
			setupIndex = 1
		}
		self.rearSetupIndex = setupIndex
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
		if self.rearSetupIndex == 0 { //Hardtail
			newBike.hasRearShock = false
			newBike.rearSetup?.isCoil = false
			
		} else if self.rearSetupIndex == 1 { //AirShock
			// set coil to false
			newBike.hasRearShock = true
			newBike.rearSetup?.isCoil = false
			
		} else if self.rearSetupIndex == 2 { // Coil
			// set coil to true
			newBike.hasRearShock = true
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
			if self.rearSetupIndex == 0 { //Hardtail
				bike.hasRearShock = false
				bike.rearSetup?.isCoil = false
				
			} else if self.rearSetupIndex == 1 { //AirShock
				// set coil to false
				bike.hasRearShock = true
				bike.rearSetup?.isCoil = false
				
			} else if self.rearSetupIndex == 2 { // Coil
				// set coil to true
				bike.hasRearShock = true
				bike.rearSetup?.isCoil = true
			}
			if self.managedObjectContext.hasChanges {
				try? self.managedObjectContext.save()
			}
		}
	}
	
	//TODO: this doesnt seem to work but works in the AddBikeView
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
