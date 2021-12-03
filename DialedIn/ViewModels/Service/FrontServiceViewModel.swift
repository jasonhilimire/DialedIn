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

class FrontServiceViewModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	//TODO: configure these as published variables in the view model
	@AppStorage("frontLowersServiceSetting") private var frontLowersServiceSetting: Int = 90
	@AppStorage("frontFullServiceSetting") private var frontFullServiceSetting: Int = 180
	

	// MARK: - PUBLISHED VARIABLES -
	
	var bikeName: String = ""
	var frontServiced = ["None", "Full", "Lower"]
	
	@Published var frontServicedIndex = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lowersServiceDate: Date = Date() {
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
	
	@Published var elapsedLowersServiceDays: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var elapsedFullServiceDays: Int = 90 {
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
	
	let didChange = PassthroughSubject<FrontServiceViewModel, Never>()
	
	init() {
//		getLastServicedDates()
	}
	
	// MARK: - FUNCTIONS -
	
	func getLastServicedDates(bike: String) {
		lowersServiceDate = getlowersDate(bike: bike)
		fullServiceDate = getFullDate(bike: bike)
		elapsedLowersServiceDays = getElapsedLowersServiceDays(lowersServiceDate)
		elapsedFullServiceDays = getElapsedFullServiceDays(fullServiceDate)
		elapsedLowersServiceWarning = lowersServiceWarning(bike: bike)
		elapsedFullServiceWarning = fullServiceWarning(bike: bike)
		serviceNote = getFrontServiceNote(bike: bike)
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
	
	func getFrontSettings(filter: String) -> [Fork] {
		var bikes : [Fork] = []
		let fetchRequest = Fork.forkFetchRequest()
		
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
	
	func getElapsedLowersServiceDays(_ lastlowersDate: Date) -> Int {
		let elapsed = daysBetween(start: lastlowersDate, end: Date())
		return elapsed
	}
	
	func getElapsedFullServiceDays(_ lastFullDate: Date) -> Int {
		let elapsed = daysBetween(start: lastFullDate, end: Date())
		return elapsed
	}
	
	func lowersServiceWarning(bike: String) -> Bool {
		let filtered = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		let setting = filtered.last?.lowersServiceWarn ?? 365
		//fetch the bike, get the lowers service setting days and then compare
		return elapsedLowersServiceDays >= setting ?  true : false
	}

	
	func fullServiceWarning(bike: String) -> Bool {
		let filtered = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		let setting = filtered.last?.fullServiceWarn ?? 365
		return elapsedFullServiceDays >= setting ? true : false
	}
	
	
	func addFrontService(bikeName: String) {
		let bike = fetchBike(for: bikeName)
		let fork = bike.frontSetup
		let newFrontService = FrontService(context: self.managedObjectContext)
		
		if frontServicedIndex == 1 {
			newFrontService.fullService = fullServiceDate
			newFrontService.lowersService = fullServiceDate
		} else if frontServicedIndex == 2 {
			// -- lowers only sets full service back to last full service --
			newFrontService.fullService = getFullDate(bike: bikeName)
			newFrontService.lowersService = lowersServiceDate
		}
		
		newFrontService.id = UUID()
		newFrontService.serviceNote = serviceNote
		fork?.addToFrontService(newFrontService)
	}
	
	func createFrontService() -> FrontService {
		let dateString = dateFormatter.string(from: Date())
		let newFrontService = FrontService(context: self.managedObjectContext)
		
		newFrontService.lowersService = self.lowersServiceDate
		newFrontService.fullService = self.fullServiceDate
		newFrontService.serviceNote = "Bike Created: \(dateString), no services found yet"
		newFrontService.id = UUID()
		
		try? self.managedObjectContext.save()
		return newFrontService
	}
	
}
