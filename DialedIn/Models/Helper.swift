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

class Helper: ObservableObject {
	
	let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	
	init() {
		//
	}
	
	@Published var lastBikeAirSetting: Int = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	let didChange = PassthroughSubject<Helper, Never>()

	
/// Put model Helpers in here when ready to refactor
	
}
