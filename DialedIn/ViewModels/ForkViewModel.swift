//
//  ForkViewModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

class ForkViewModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	// MARK: - Published Variables
	
	let didChange = PassthroughSubject<ForkViewModel, Never>()
	
	// MARK: - Fork Details -
	
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
    
    @Published var dualAir: Bool = false {
        didSet {
            didChange.send(self)
        }
    }
	
	@Published var info: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var travelString: String? = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var travel: Double = 0.0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var lowersServiceSettingDays: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fullServiceSettingDays: Int = 90 {
		didSet {
			didChange.send(self)
		}
	}

	// MARK: - FUNCTIONS -
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
	

	func getDualComp(bike: String) -> Bool {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return filteredBike.last?.dualCompression ?? true
	}
	
	func getDualReb(bike: String) -> Bool {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return filteredBike.last?.dualRebound ?? true
	}
    
    func getDualAir(bike: String) -> Bool {
        let filteredBike = getFrontSettings(filter: bike).filter { bikes in
            bikes.bike?.frontSetup?.bike?.name == bike
        }
        return filteredBike.last?.dualAir ?? true
    }
	
	func getTravel(bike: String) -> Double {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return filteredBike.last?.travel ?? 0.0
	}
	
	func getTravelString(bike: String) -> String {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return String(filteredBike.last?.travel ?? 0.0)
	}
	
	
	func getInfo(bike: String) -> String {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return filteredBike.last?.info ?? ""
	}
	
	func getLowersServiceSettingDays(bike: String) -> Int {
		let filtered = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return Int(filtered.last?.lowersServiceWarn ?? 365)
	}
	
	func getFullServiceSettingDays(bike: String) -> Int {
		let filtered = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return Int(filtered.last?.fullServiceWarn ?? 365)
	}
	
	func getForkSettings(bikeName: String){
		dualCompression = getDualComp(bike: bikeName)
		dualRebound = getDualReb(bike: bikeName)
        dualAir = getDualAir(bike: bikeName)
		travelString = getTravelString(bike: bikeName)
		travel = getTravel(bike: bikeName)
		info = getInfo(bike: bikeName)
		lowersServiceSettingDays = getLowersServiceSettingDays(bike: bikeName)
		fullServiceSettingDays = getFullServiceSettingDays(bike: bikeName)
	}
	
	func convertTravel(from travel: String) -> Double {
		let converted: Double
		converted = Double(travel) ?? 0.0
		return converted
	}
	
	func createFork(_ frontService: FrontService) -> Fork {
		let newFork = Fork(context: self.managedObjectContext)
		newFork.id = UUID()
		newFork.dualCompression = self.dualCompression
		newFork.dualRebound = self.dualRebound
        newFork.dualAir = self.dualAir
		newFork.travel = convertTravel(from: travelString!)
		newFork.lowersServiceWarn = Int16(self.lowersServiceSettingDays)
		newFork.fullServiceWarn = Int16(self.fullServiceSettingDays)
		
		if self.info == "" {
			newFork.info = "Fork"
		} else {
			newFork.info = self.info
		}
		
		newFork.addToFrontService(frontService)
		try? self.managedObjectContext.save()
		return newFork
		
	}
	
	func updateFork(fork: Fork) -> Fork {
		managedObjectContext.performAndWait {
			fork.dualCompression = self.dualCompression
			fork.dualRebound = self.dualRebound
            fork.dualAir = self.dualAir
			fork.lowersServiceWarn = Int16(self.lowersServiceSettingDays)
			fork.fullServiceWarn = Int16(self.fullServiceSettingDays)
			if self.info == "" {
				fork.info = "Fork"
			} else {
				fork.info = self.info
			}
			fork.travel = convertTravel(from: self.travelString!)
			if self.managedObjectContext.hasChanges {
				try? self.managedObjectContext.save()
			}
		}
		return fork
	}
	
	func deleteFork(_ fork: Fork){
		managedObjectContext.delete(fork)
		try? self.managedObjectContext.save()
	}
	
	
}
