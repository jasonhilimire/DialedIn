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
import CoreData

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
		
//		print("FilteredBike: \(filteredBikes)") /// returning an empty array?
		return filteredBikes
	}
	
	//// now working!!
	func getLowers(filter: String) -> [FrontService] {
		var bikes : [FrontService] = []
		let fetchRequest = FrontService.frontServiceLowersFetchRequest(filter: bikeName)
//		fetchRequest.fetchLimit = 1
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes
	}
	
	func getlowersDate(bike: String) -> Date {
		let filteredService = getLowers(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		print("Last Lowers Service: \(filteredService.last?.lowersService)")

		return filteredService.last?.lowersService ?? Date()

	}

	
	////
	
	
	func getLastServicedDates() {
//		lastLowerService = getLastLowersService()
		lastLowerService = getlowersDate(bike: bikeName)
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

