//
//  FrontServiceModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class FrontServiceModel: ObservableObject {
	
	let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	init() {
		setup()
	}
	
	@Published var bikeName: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lastLowerService: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lastFullService: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	let didChange = PassthroughSubject<FrontServiceModel, Never>()
	
	func getLastLowerService() -> Date {
		let last = filter(for: bikeName)
		let lastserv = last.last?.frontSetup?.lowerLastServiced
		return lastserv ?? Date()
	}
	
	func getLastFullService() -> Date {
		let last = filter(for: bikeName)
		let lastserv = last.last?.frontSetup?.lasfFullService
		return lastserv ?? Date()
	}
	
	func getBikes() -> [Bike] {
		let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
		return bikes
	}
	
	func filter(for name: String) -> [Bike] {
		let filteredBikes = getBikes().filter { bikes in
			bikes.name == name
		}
		return filteredBikes
	}
	
	func setup() {
		lastLowerService = getLastLowerService()
		lastFullService = getLastFullService()
	}
	
}

