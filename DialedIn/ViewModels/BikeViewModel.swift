//
//  BikeModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public class BikeViewModel: ObservableObject {
    
	let moc = PersistentCloudKitContainer.context
    
    
//    init() {
//        getLastBike()
//    }
    
	
	@Published var name: String = "" {
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
	
	//TODO: ADD REARSETUP CONNECTION
	//TODO: ADD SETUPNOTES Connection
	
	// MARK: - CRUD -
	
	 class func newBike() -> Bike{
		let moc = PersistentCloudKitContainer.context
		let newBike = Bike(context: moc)
		return newBike
	}

	
	class func createBike(name: String, bikeNote: String, isDefault: Bool, fork: ForkViewModel, rear: RearShockViewModel, rearSetupIndex: Int) -> Bike {
		//TODO: This doesnt follow the convention in Addbike view that is currently working :/
		let bike = BikeViewModel.newBike()
		
		
		bike.id = UUID()
		bike.name = name
		bike.bikeNote = bikeNote
		bike.isDefault = isDefault

		
		// Front Setup
		bike.frontSetup?.dualCompression = fork.dualCompression
		bike.frontSetup?.dualRebound = fork.dualRebound
		bike.frontSetup?.info = fork.info
		bike.frontSetup?.travel = fork.travel
		
		// Rear Setup
		if rearSetupIndex == 1 {
			bike.hasRearShock = true
			bike.rearSetup?.info = rear.info
			bike.rearSetup?.strokeLength = rear.strokeLength
			bike.rearSetup?.dualCompression = rear.dualCompression
			bike.rearSetup?.dualRebound = rear.dualRebound
			bike.rearSetup?.isCoil = rear.isCoil
//			newRearService.airCanService = self.lastAirCanServiceDate
//			newRearService.fullService = self.lastRearFullServiceDate
//			bike.rearSetup..serviceNote = "Bike Created: \(dateString), no services found yet"
			
		} else if rearSetupIndex == 2 {
//			self.isCoilToggle.toggle()
			
			bike.hasRearShock = true
			bike.rearSetup?.info = rear.info
			bike.rearSetup?.strokeLength = rear.strokeLength
			bike.rearSetup?.dualCompression = rear.dualCompression
			bike.rearSetup?.dualRebound = rear.dualRebound
			bike.rearSetup?.isCoil = rear.isCoil
//			newRearService.airCanService = self.lastAirCanServiceDate
//			newRearService.fullService = self.lastRearFullServiceDate
//			newRearService.serviceNote = "Bike Created: \(dateString), no services found yet"
			
		} else if rearSetupIndex == 0 {
			bike.hasRearShock = false
			bike.rearSetup?.isCoil = false
		}
		
		
		PersistentCloudKitContainer.saveContext()
		return bike
	}
	
	
	public func update(name: String, bikeNote: String, isDefault: Bool, hasRearShock: Bool) {
		self.name = name
		self.bikeNote = bikeNote
		self.isDefault = isDefault
		self.hasRearShock = hasRearShock
		PersistentCloudKitContainer.saveContext()
	}

	public func delete() {
//		PersistentCloudKitContainer.context.delete(self)
	}
    
    let didChange = PassthroughSubject<BikeViewModel, Never>()

	func getBikes() -> [Bike] {
		let bikes = try! moc.fetch(Bike.bikesFetchRequest())
		return bikes
	}
	
	func filterBikes(for name: String) -> [Bike] {
		let filteredBike = getBikes().filter { bikes in
			bikes.name == name
		}
		return filteredBike
	}
	
	
	func getRear() -> Bool {
		let last = filterBikes(for: name)
		guard let rear = last.last?.hasRearShock else {return true}
		return rear
	}
	
	func getDefault() -> Bool {
		let last = filterBikes(for: name)
		guard let rear = last.last?.isDefault else {return false}
		return rear
	}
	
	
	func getNote() -> String {
		let last = filterBikes(for: name)
		guard let rear = last.last?.bikeNote else {return ""}
		return rear
	}
	
    func getLastBike() {
        bikeNote = getNote()
		hasRearShock = getRear()
		isDefault = getDefault()
    }

}
