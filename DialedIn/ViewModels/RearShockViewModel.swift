//
//  RearShockViewModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/1/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

public class RearShockViewModel: ObservableObject {
	
	@Published var dualCompression: Bool = false
	@Published var dualRebound: Bool = false
	@Published var info: String = ""
	@Published var isCoil: Bool = false
	@Published var rearTravel: Double = 0.0
	@Published var strokeLength: Double = 0.0
	
	class func newRearShock() -> RearShock{
		let moc = PersistentCloudKitContainer.context
		let newRear = RearShock(context: moc)
		return newRear
	}
	
	class func createRearShock(dualCompression: Bool, dualRebound: Bool, info: String, isCoil: Bool, rearTravel: Double, strokeLength: Double) -> RearShock {
		let rear = RearShockViewModel.newRearShock()
		
		rear.id = UUID()
		rear.dualCompression = dualCompression
		rear.dualRebound = dualRebound
		rear.info = info
		rear.isCoil = isCoil
		rear.rearTravel = rearTravel
		rear.strokeLength = strokeLength
		PersistentCloudKitContainer.saveContext()
		return rear
	}
	
	public func update(dualCompression: Bool, dualRebound: Bool, info: String, isCoil: Bool, rearTravel: Double, strokeLength: Double) {
		self.dualCompression = dualCompression
		self.dualRebound = dualRebound
		self.info = info
		self.isCoil = isCoil
		self.rearTravel = rearTravel
		self.strokeLength = strokeLength
		PersistentCloudKitContainer.saveContext()
	}
	
	// DELETE needed??
	
}
