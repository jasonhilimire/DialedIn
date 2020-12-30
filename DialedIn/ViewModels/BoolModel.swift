//
//  BoolModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/30/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

class BoolModel: ObservableObject {
	let didChange = PassthroughSubject<BoolModel, Never>()
	
	@Published var isShowingService: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var isShowingEdit: Bool = false{
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var bikeName: String = ""{
		didSet {
			didChange.send(self)
		}
	}	
}
