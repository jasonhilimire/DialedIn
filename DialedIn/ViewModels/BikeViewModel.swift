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
    
	@Published var bikeName: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var bikeNote: String = "" {
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
	
	
	func getRear() -> Bool {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.hasRearShock else {return true}
		return rear
	}
	
	func getDefault() -> Bool {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.isDefault else {return false}
		return rear
	}
	
	
	func getNote() -> String {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.bikeNote else {return ""}
		return rear
	}
	
    func getLastBike() {
        bikeNote = getNote()
		hasRearShock = getRear()
		isDefault = getDefault()
    }
	
	func saveNewBike(fork: Fork, rearShock: RearShock, frontService: FrontService, rearService: RearService) {
		let newBike = Bike(context: managedObjectContext)
		
		
		newBike.id = UUID()
		newBike.name = self.bikeName
		newBike.bikeNote = self.bikeNote
		newBike.isDefault = self.isDefault
		newBike.hasRearShock = self.hasRearShock
		
		

		
		// - Rear Creation -
		
		
		if self.rearSetupIndex == 1 {
			// set coil to false
			newBike.hasRearShock = true
			
			
		} else if self.rearSetupIndex == 2 {
			// set coil to true
			
			newBike.hasRearShock = true

			
		} else if self.rearSetupIndex == 0 {
			// set coil to true
			newBike.hasRearShock = false
			
		}
		
		try? self.managedObjectContext.save()
		
	}
	
	
	func checkBikeNameExists() {
		let filteredBikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
		for bike in filteredBikes {
			if bike.name?.lowercased() == bikeName.lowercased() {
				duplicateNameAlert.toggle()
				break
			}
		}
	}

}
