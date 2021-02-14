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
	
	@Published var dualCompression: Bool = true {
		didSet {
			didChange.send(self)
		}
	}
	@Published var dualRebound: Bool = true {
		didSet {
			didChange.send(self)
		}
	}
	@Published var info: String? = "" {
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
	
	func getTravel(bike: String) -> Double {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return filteredBike.last?.travel ?? 0.0
	}
	
	
	func getInfo(bike: String) -> String {
		let filteredBike = getFrontSettings(filter: bike).filter { bikes in
			bikes.bike?.frontSetup?.bike?.name == bike
		}
		return filteredBike.last?.info ?? ""
	}
	
	func getForkSettings(bikeName: String){
		dualCompression = getDualComp(bike: bikeName)
		dualRebound = getDualReb(bike: bikeName)
		travel = getTravel(bike: bikeName)
		info = getInfo(bike: bikeName)
	}
	
	// TODO: ADD Create Update Delete
	//
	
	func createFork(_ frontService: FrontService) -> Fork {
		let newFork = Fork(context: self.managedObjectContext)
		newFork.id = UUID()
		newFork.dualCompression = self.dualCompression
		newFork.dualRebound = self.dualRebound
		newFork.travel = self.travel
		
		if self.info == "" {
			newFork.info = "Fork"
		} else {
			newFork.info = self.info
		}
		
		newFork.addToFrontService(frontService)
		try? self.managedObjectContext.save()
		return newFork
		
	}
	
	
}
