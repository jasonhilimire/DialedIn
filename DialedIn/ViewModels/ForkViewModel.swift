//
//  ForkViewModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/1/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

public class ForkViewModel : ObservableObject {
	
	// initializer??
	
	@Published var id = UUID() // ? need this
	@Published var dualCompression: Bool = false
	@Published var dualRebound: Bool = false
	@Published var info: String = ""
	@Published var travel: Double = 0.0
	
	// MARK: - CRUD -
	
	class func newFork() -> Fork{
		let moc = PersistentCloudKitContainer.context
		let newFork = Fork(context: moc)
		return newFork
	}
	
	class func createFork(dualCompression: Bool, dualRebound: Bool, info: String, travel: Double) -> Fork {
		let fork = ForkViewModel.newFork()
		fork.id = UUID()
		fork.dualCompression = dualCompression
		fork.dualRebound = dualRebound
		fork.info = info
		fork.travel = travel
		
		PersistentCloudKitContainer.saveContext()
		return fork
	}
	
	public func update(dualCompression: Bool, dualRebound: Bool, info: String, travel: Double) {
		self.dualCompression = dualCompression
		self.dualRebound = dualRebound
		self.info = info
		self.travel = travel
		PersistentCloudKitContainer.saveContext()
	}
	

// DELETE needed??
}
