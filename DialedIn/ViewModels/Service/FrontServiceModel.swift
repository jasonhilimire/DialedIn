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
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	@AppStorage("frontLowersServiceSetting") private var frontLowersServiceSetting: Int = 90
	@AppStorage("frontFullServiceSetting") private var frontFullServiceSetting: Int = 180
	
	// MARK: - PUBLISHED VARIABLES -
	
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
	
	@Published var elapsedLowerServiceDate: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedFullServiceDate: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedLowersServiceWarning: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedFullServiceWarning: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	let didChange = PassthroughSubject<FrontServiceModel, Never>()
	
	init() {
		getLastServicedDates()
	}
	
	// MARK: - FUNCTIONS -
	
	func getLastServicedDates() {
		lastLowerService = getlowersDate(bike: bikeName)
		lastFullService = getFullDate(bike: bikeName)
		elapsedLowerServiceDate = daysBetween(start: lastLowerService, end: Date())
		elapsedFullServiceDate = daysBetween(start: lastFullService, end: Date())
		elapsedLowersServiceWarning = lowersServiceWarning()
		elapsedFullServiceWarning = fullServiceWarning()
	}
	
	//// now working!! might only need this and delete rest?
	func getFrontServices(filter: String) -> [FrontService] {
		var bikes : [FrontService] = []
		//		let fetchRequest = FrontService.frontServiceLowersFetchRequest(filter: bikeName) /// maybe need this if multiple service issue due to sorting by full service only
		let fetchRequest = FrontService.frontServiceFetchRequest()
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes
	}
	
	func getlowersDate(bike: String) -> Date {
		let filteredService = getFrontServices(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		return filteredService.last?.lowersService ?? Date()
	}
	
	func getFullDate(bike: String) -> Date {
		let filteredService = getFrontServices(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		return filteredService.last?.fullService ?? Date()
	}
	
	func getFrontServiceNote(bike: String) -> String {
		let filteredService = getFrontServices(filter: bike).filter { bikes in
			bikes.service?.bike?.name == bike
		}
		return filteredService.last?.serviceNote ?? ""
	}
	
	
	func lowersServiceWarning() -> Bool {
		elapsedLowerServiceDate >= frontLowersServiceSetting ?  true : false
	}
	
	func fullServiceWarning() -> Bool {
		elapsedFullServiceDate >= frontFullServiceSetting ? true : false
	}
}
