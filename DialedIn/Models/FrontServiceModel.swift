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
		getLastServicedDates()
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
	
	func getLastLowersService() -> Date {
		let lastLower = ServiceDates.lowers
		return lastLower.getLastServiceDates(frontService: filterFront(for: bikeName))
	}
	
	func getLastFullService() -> Date {
		let lastFull = ServiceDates.full
		return lastFull.getLastServiceDates(frontService: filterFront(for: bikeName))
	}
	
	func getFork() -> [FrontService] {
		let fork = try! managedObjectContext.fetch(FrontService.frontServiceFetchRequest())
		return fork
	}
	
	func filterFront(for name: String) -> [FrontService] {
		let filteredBikes = getFork().filter { bikes in
			bikes.service?.bike?.name == name
		}
		return filteredBikes
	}
	
	//// not working?
	func getBike(filter: String) -> Bike {
		var bikes : [Bike] = []
		let fetchRequest = Bike.selectedBikeFetchRequest(filter: bikeName)
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes[0]
	}
	
	func getlowers(bike: String) -> Date {
		let filteredBike = getBike(filter: bike)
		let last = filteredBike.frontSetup?.frontServiceArray.last
		print(last?.lowersService)
		return (last?.lowersService)!

	}
	////
	
	
	func getLastServicedDates() {
		lastLowerService = getLastLowersService()
		lastFullService = getLastFullService()
	}
	
	enum ServiceDates {
		case lowers
		case full
		
		func getLastServiceDates(frontService: [FrontService]) -> Date {
			switch self {
				case .lowers:
					return frontService.last?.lowersService ?? Date()
				case .full:
					return frontService.last?.fullService ?? Date()
				
			}
		}
	}
	
}

