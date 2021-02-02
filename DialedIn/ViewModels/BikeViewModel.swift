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
	
	//TODO: ADD FRONTSETUP CONNECTION
	//TODO: ADD REARSETUP CONNECTION
	//TODO: ADD SETUPNOTES Connection
	
	// MARK: - CRUD -
	
	 class func newBike() -> Bike{
		let moc = PersistentCloudKitContainer.context
		let newBike = Bike(context: moc)
		return newBike
	}

	
	class func createBike(name: String, bikeNote: String, isDefault: Bool, hasRearShock: Bool) -> Bike {
		let bike = BikeViewModel.newBike()
		bike.name = name
		bike.bikeNote = bikeNote
		bike.isDefault = isDefault
		bike.hasRearShock = hasRearShock
		// Front Setup?
		// Rear Setup?
		// Setup Notes?
		
		PersistentCloudKitContainer.saveContext()
		return bike
	}
	
	
	public func update() {

		PersistentCloudKitContainer.saveContext()
	}

	public func delete() {
		PersistentCloudKitContainer.context.delete(self)
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
