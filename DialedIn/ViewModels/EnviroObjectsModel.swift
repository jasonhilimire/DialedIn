//
//  BoolModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/30/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

class EnviroObjectsModel: ObservableObject {
	let didChange = PassthroughSubject<EnviroObjectsModel, Never>()
	
	@Published var isShowingService: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var isShowingEdit: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var bikeName: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	// TODO: Stub out rest of service warnings
	@Published var frontServiceWarning: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
}
