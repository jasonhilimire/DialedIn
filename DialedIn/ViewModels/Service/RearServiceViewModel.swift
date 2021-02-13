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

class RearServiceViewModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	@AppStorage("rearAirCanServiceSetting") private var rearAirCanServiceSetting: Int = 90
	@AppStorage("rearFullServiceSetting") private var rearFullServiceSetting: Int = 180
	
	// MARK: - PUBLISHED VARIABLES -
	
	var bikeName: String = ""
	var rearServiced = ["None", "Full", "AirCan"]
	
	@Published var rearServicedIndex = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var airCanServicedDate: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fullServiceDate: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var serviceNote: String = "" {
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
	
	let didChange = PassthroughSubject<RearServiceViewModel, Never>()

	
	init() {
//		getLastServicedDates()
	}
	
	// MARK: - FUNCTIONS -
	
	func getLastServicedDates(bike: String) {
		airCanServicedDate = getAirCanDate(bike: bike)
		fullServiceDate = getFullDate(bike: bike)
		elapsedAirCanServiceDate = getElapsedAirCanServiceDate(airCanServicedDate)
		elapsedFullServiceDate = getElapsedFullServiceDate(fullServiceDate)
		elapsedAirCanServiceWarning = airCanServiceWarning()
		elapsedFullServiceWarning = fullServiceWarning()
		serviceNote = getRearServiceNote(bike: bike)
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
	
	func getElapsedAirCanServiceDate(_ lastAirCanDate: Date) -> Int {
		let elapsed = daysBetween(start: lastAirCanDate, end: Date())
		return elapsed
	}
	
	func getElapsedFullServiceDate(_ lastFullDate: Date) -> Int {
		let elapsed = daysBetween(start: lastFullDate, end: Date())
		return elapsed
	}
		
	func airCanServiceWarning() -> Bool {
		elapsedAirCanServiceDate >= rearAirCanServiceSetting ?  true : false
	}
	
	func fullServiceWarning() -> Bool {
		elapsedFullServiceDate >= rearFullServiceSetting ? true : false
	}
	
	func addRearService(bikeName: String) {
		 let bike = fetchBike(for: bikeName)
		 let rear = bike.rearSetup
		 let newRearService = RearService(context: self.managedObjectContext)
		
		 if rearServicedIndex == 1 {
			newRearService.fullService = fullServiceDate
			newRearService.airCanService = fullServiceDate
		 } else if rearServicedIndex == 2 {
		 	// -- lowers only sets full service back to last full service --
		 	newRearService.fullService = getFullDate(bike: bikeName)
			newRearService.airCanService = airCanServicedDate
		 }
		
		 newRearService.id = UUID()
		 newRearService.serviceNote = serviceNote
		 rear?.addToRearService(newRearService)
	}
}
