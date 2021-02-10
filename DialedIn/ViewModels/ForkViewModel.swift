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
	
	let didChange = PassthroughSubject<NoteViewModel, Never>()
	
	// MARK: - Fork Details -
	
	@Published var dualCompression: Bool
	@Published var dualRebound: Bool
	@Published var info: String?
	@Published var travel: Double
	
	init(dualCompression: Bool, dualRebound: Bool, info: String, travel: Double) {
		self.dualCompression = dualCompression
		self.dualRebound = dualRebound
		self.info = info
		self.travel = travel
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
	
//TODO: Utilize these and refactor out of NoteFrontSetup
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
	
	
}
