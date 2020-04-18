//
//  BikeModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BikeModel: ObservableObject {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    init() {
        getLastBike()
    }
    
	@Published var bikeName: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var bikeNote: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var isDefault: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var hasRearShock: Bool = true {
		didSet {
			didChange.send(self)
		}
	}
	
    
    let didChange = PassthroughSubject<BikeModel, Never>()

	func getBikes() -> [Bike] {
		let bikes = try! managedObjectContext.fetch(Bike.bikesFetchRequest())
		return bikes
	}
	
	func filterBikes(for name: String) -> [Bike] {
		let filteredBike = getBikes().filter { bikes in
			bikes.name == name
		}
		return filteredBike
	}
	
	
	func getRear() -> Bool {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.hasRearShock else {return true}
		return rear
	}
	
	func getDefault() -> Bool {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.isDefault else {return false}
		return rear
	}
	
	
	func getNote() -> String {
		let last = filterBikes(for: bikeName)
		guard let rear = last.last?.bikeNote else {return ""}
		return rear
	}
	
    func getLastBike() {
        bikeNote = getNote()
		hasRearShock = getRear()
		isDefault = getDefault()
    }

}
