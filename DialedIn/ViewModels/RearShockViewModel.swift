//
//  RearShockViewModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/14/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

class RearShockViewModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	// MARK: - Published Variables
	
	let didChange = PassthroughSubject<RearShockViewModel, Never>()

//	var id: UUID
	
	@Published var dualCompression: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var dualRebound: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var info: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var isCoil: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var strokeLength: Double = 0.0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var travel: Double = 0.0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var strokeLengthString: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var travelString: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var airCanServiceSettingDays: Int = 180 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fullServiceSettingDays: Int = 180 {
		didSet {
			didChange.send(self)
		}
	}
	
	
	
	// MARK: - FUNCTIONS -
	
	func getRearSettings(filter: String) -> [RearShock] {
		var bikes : [RearShock] = []
		let fetchRequest = RearShock.rearFetchRequest()
		
		do {
			bikes = try managedObjectContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return bikes
	}
	
	
	func getRearInfo(bike: String) -> String {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.info ?? ""
	}
	
	func getDualComp(bike: String) -> Bool {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.dualCompression ?? true
	}
	
	func getDualReb(bike: String) -> Bool {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.dualRebound ?? true
	}
	
	func getCoil(bike: String) -> Bool {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.isCoil ?? false
	}
	
	func getTravel(bike: String) -> Double {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.rearTravel ?? 0.0
	}
	
	func getStrokeLength(bike: String) -> Double {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return filteredBike.last?.strokeLength ?? 0.0
	}
	
	func getTravelString(bike: String) -> String {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return String(filteredBike.last?.rearTravel ?? 0.0)
	}
	
	func getStrokeLengthString(bike: String) -> String {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return String(filteredBike.last?.strokeLength ?? 0.0)
	}
	
	func convertTravel(from travel: String) -> Double {
		let converted: Double
		converted = Double(travel) ?? 0.0
		return converted
	}
	
	func getAirCanServiceSettingDays(bike: String) -> Int {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return Int(filteredBike.last?.airCanServiceWarn ?? 365)
	}
	
	func getFullServiceSettingDays(bike: String) -> Int {
		let filteredBike = getRearSettings(filter: bike).filter { bikes in
			bikes.bike?.rearSetup?.bike?.name == bike
		}
		return Int(filteredBike.last?.fullServiceWarn ?? 365)
	}
	
	
	func getRearSetup(bikeName: String){
		dualRebound = getDualReb(bike: bikeName)
		dualCompression = getDualComp(bike: bikeName)
		isCoil = getCoil(bike: bikeName)
		strokeLength = getStrokeLength(bike: bikeName)
		travel = getTravel(bike: bikeName)
		strokeLengthString = getStrokeLengthString(bike: bikeName)
		travelString = getTravelString(bike: bikeName)
		info = getRearInfo(bike: bikeName)
		airCanServiceSettingDays = getAirCanServiceSettingDays(bike: bikeName)
		fullServiceSettingDays = getFullServiceSettingDays(bike: bikeName)
	}
	
	func createRearShock(_ rearService: RearService) -> RearShock {
		let rearShock = RearShock(context: self.managedObjectContext)
		rearShock.id = UUID()
		rearShock.dualCompression = self.dualCompression
		rearShock.dualRebound = self.dualRebound
		rearShock.rearTravel = convertTravel(from: self.travelString!)
		rearShock.isCoil = self.isCoil
		rearShock.strokeLength = convertTravel(from: self.strokeLengthString!)
		rearShock.airCanServiceWarn = Int16(self.airCanServiceSettingDays)
		rearShock.fullServiceWarn = Int16(self.fullServiceSettingDays)
		
		if self.info == "" {
			rearShock.info = "Rear Shock"
		} else {
			rearShock.info = self.info
		}
		
		rearShock.addToRearService(rearService)
		try? self.managedObjectContext.save()
		return rearShock
		
	}
	
	func updateRearShock(rear: RearShock) -> RearShock {
		managedObjectContext.performAndWait {
			rear.dualCompression = self.dualCompression
			rear.dualRebound = self.dualRebound
			if self.info == "" {
				rear.info = "Rear Shock"
			} else {
				rear.info = self.info
			}
			rear.rearTravel = convertTravel(from: self.travelString!)
			rear.strokeLength = convertTravel(from: self.strokeLengthString!)
			rear.airCanServiceWarn = Int16(self.airCanServiceSettingDays)
			rear.fullServiceWarn = Int16(self.fullServiceSettingDays)
			
			if self.managedObjectContext.hasChanges {
				try? self.managedObjectContext.save()
			}
		}
		return rear
	}
	
	func deleteRearShock(_ rear: RearShock) {
		managedObjectContext.delete(rear)
		try? self.managedObjectContext.save()
	}
	
}
