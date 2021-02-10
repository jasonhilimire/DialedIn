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
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	@AppStorage("rearAirCanServiceSetting") private var rearAirCanServiceSetting: Int = 90
	@AppStorage("rearFullServiceSetting") private var rearFullServiceSetting: Int = 180
	
	// MARK: - PUBLISHED VARIABLES -
	
	@Published var bikeName: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lastAirService: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lastFullService: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedAirCanServiceDate: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedFullServiceDate: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedAirCanServiceWarning: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedFullServiceWarning: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	let didChange = PassthroughSubject<RearServiceModel, Never>()

	
	init() {
		getLastServicedDates()
	}
	
	// MARK: - FUNCTIONS -
	
	func getLastServicedDates() {
		lastAirService = getAirCanDate(bike: bikeName)
		lastFullService = getFullDate(bike: bikeName)
		elapsedAirCanServiceDate = daysBetween(start: lastAirService, end: Date())
		elapsedFullServiceDate = daysBetween(start: lastFullService, end: Date())
		elapsedAirCanServiceWarning = airCanServiceWarning()
		elapsedFullServiceWarning = fullServiceWarning()
	}
	
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
		
	func airCanServiceWarning() -> Bool {
		elapsedAirCanServiceDate >= rearAirCanServiceSetting ?  true : false
	}
	
	func fullServiceWarning() -> Bool {
		elapsedFullServiceDate >= rearFullServiceSetting ? true : false
	}
}
