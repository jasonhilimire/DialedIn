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
	
	func getRearShock() -> [FrontService] {
		let rearShocks = try! managedObjectContext.fetch(FrontService.frontServiceFetchRequest())
		return rearShocks
	}
	
	func filterFront(for name: String) -> [FrontService] {
		let filteredBikes = getRearShock().filter { bikes in
			bikes.service?.bike?.name == name
		}
		return filteredBikes
	}
	
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

