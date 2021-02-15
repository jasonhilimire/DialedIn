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
	
	
	func getRearSetup(bikeName: String){
		//TODO: RearFactor into own RearViewModel
		dualRebound = getDualReb(bike: bikeName)
		dualCompression = getDualComp(bike: bikeName)
		isCoil = getCoil(bike: bikeName)
		strokeLength = getStrokeLength(bike: bikeName)
		travel = getTravel(bike: bikeName)
	}
	
	// TODO: ADD Create Update Delete
	
	func createRearShock(_ rearService: RearService) -> RearShock {
		let rearShock = RearShock(context: self.managedObjectContext)
		rearShock.id = UUID()
		rearShock.dualCompression = self.dualCompression
		rearShock.dualRebound = self.dualRebound
		rearShock.rearTravel = self.travel
		rearShock.isCoil = self.isCoil
		rearShock.strokeLength = self.strokeLength
		
		if self.info == "" {
			rearShock.info = "RearShock"
		} else {
			rearShock.info = self.info
		}
		
		rearShock.addToRearService(rearService)
		try? self.managedObjectContext.save()
		return rearShock
		
	}
	
}
