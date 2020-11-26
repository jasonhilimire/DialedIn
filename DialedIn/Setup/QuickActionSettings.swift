//
//  QuickActionSettings.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/25/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation

class QuickActionSettings: ObservableObject {
	
	enum QuickAction: Hashable {
		case home
		case details(name: String)
	}
	
	@Published var quickAction: QuickAction? = nil
}
