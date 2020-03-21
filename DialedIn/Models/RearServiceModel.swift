//
//  RearServiceModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RearServiceModel: ObservableObject {
	
	let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	
	init() {
		setup()
	}
	
	@Published var bikeName: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lastAirServ: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lastFullServ: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	let didChange = PassthroughSubject<RearServiceModel, Never>()

// update with enum
	func getLastAirService() -> Date {
		return getSetting(service: filterRear(for: bikeName))
	}
	

	func getLastFullService() -> Date {
		let last = filterBikes(for: bikeName)
		let lastserv = last.last?.rearSetup?.lastFullService
		return lastserv ?? Date()
	}
	

// Change to an enum?
	func getSetting(service: [RearService]) -> Date {
		let lastAir = service.last?.airCanService
		return lastAir ?? Date()
	}
	
	
	func getBikes() -> [Bike] {
		let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
		return bikes
	}
	
	func getRearShock() -> [RearService] {
		let rearShocks = try! managedObjectContext.fetch(RearService.rearFetchRequest())
		return rearShocks
	}

// wont be needed
	func filterBikes(for name: String) -> [Bike] {
		let filteredBikes = getBikes().filter { bikes in
			bikes.name == name
		}
		return filteredBikes
	}
	
	func filterRear(for name: String) -> [RearService] {
		let filteredBikes = getRearShock().filter { bikes in
			bikes.service?.bike?.name == name
		}
		return filteredBikes
	}
	

	
	func setup() {
		lastAirServ = getLastAirService()
		lastFullServ = getLastFullService()
	}
	
}
