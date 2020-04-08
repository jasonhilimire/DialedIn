//
//  Helper.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/31/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

var dateFormatter: DateFormatter {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	return formatter
}

class Helper: ObservableObject {
	
	let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	

	
	
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	// create a Fetch request for Bike
	@FetchRequest(fetchRequest: FrontService.frontServiceFetchRequest())
	var frontServices: FetchedResults<FrontService>
	init() {
		//
	}
	
	@Published var lastlower: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	let didChange = PassthroughSubject<Helper, Never>()
	
	func filter(name: String) -> [FrontService] {
		let filtered = frontServices.filter { bikes in
			bikes.service?.bike?.name == name
		}
		return filtered
	}

	
/// Put model Helpers in here when ready to refactor
	
}


