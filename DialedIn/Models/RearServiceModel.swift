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
	
	
	//// now working!! might only need this and delete rest?
	func getRearServices(filter: String) -> [RearService] {
		var bikes : [RearService] = []
		// maybe need specific fetch  if multiple service issue due to sorting by full service only
		let fetchRequest = RearService.rearServiceFetchRequest()
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes
	}
	
	func getAirCanDate(bike: String) -> Date {
		let filteredService = getRearServices(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		return filteredService.last?.airCanService ?? Date()
	}
	
	func getFullDate(bike: String) -> Date {
		let filteredService = getRearServices(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		return filteredService.last?.fullService ?? Date()
	}
	
	func getRearServiceNote(bike: String) -> String {
		let filteredService = getRearServices(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		return filteredService.last?.serviceNote ?? ""
	}
	
	////
	
	
	init() {
		getLastServicedDates()
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

	func getLastAirService() -> Date {
		let lastAir = ServiceDates.airCan
		return lastAir.getLastServiceDates(rearservice: filterRear(for: bikeName))
	}
	
	func getLastFullService() -> Date {
		let lastFull = ServiceDates.full
		return lastFull.getLastServiceDates(rearservice: filterRear(for: bikeName))
	}
	
	func getRearShock() -> [RearService] {
		let rearShocks = try! managedObjectContext.fetch(RearService.rearServiceFetchRequest())
		return rearShocks
	}

	func filterRear(for name: String) -> [RearService] {
		let filteredBikes = getRearShock().filter { bikes in
			bikes.service?.bike?.name == name
		}
		return filteredBikes
	}
	
	func getLastServicedDates() {
		lastAirServ = getLastAirService()
		lastFullServ = getLastFullService()
	}
	
	enum ServiceDates {
		case airCan
		case full
		
		func getLastServiceDates(rearservice: [RearService]) -> Date {
			switch self {
				case .airCan:
					return rearservice.last?.airCanService ?? Date()
				case .full:
					return rearservice.last?.fullService ?? Date()
				
			}
		}
	}
	
}
