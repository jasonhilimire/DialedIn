//
//  NoteModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/28/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class EditNoteViewModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	// MARK: - Published Variables
	
	let didChange = PassthroughSubject<EditNoteViewModel, Never>()
	
	// MARK: - Note Details -
	@Published var noteText: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteRating: Int = 1 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteFavorite: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteDate: Date = Date() {
		didSet {
			didChange.send(self)
		}
	}
	
	// MARK: - FRONT SETTINGS -
	@Published var fAirVolume: Double = 45.5 {
		didSet {
			didChange.send(self)
		}
	}
	
	
	@Published var fCompSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fHSCSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fLSCSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fReboundSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fHSRSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fLSRSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fTokenSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fSagSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
		
	@Published var fTirePressure: Double = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	// MARK: - REAR SETTINGS -
	
	@Published var rSpring: Double = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rCompSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rHSCSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rLSCSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rReboundSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rHSRSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rLSRSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rTokenSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var rSagSetting: Int16 = 0 {
		didSet {
			didChange.send(self)
		}
	}

	@Published var rTirePressure: Double = 0.0 {
		didSet {
			didChange.send(self)
		}
	}
	
	init() {
		//
	}

	// MARK: - FUNCTIONS
	
	func getNoteModel(note: Notes) {
		noteText = note.note ?? ""
		noteRating = Int(note.rating)
		noteFavorite = note.isFavorite
		noteDate = note.date ?? Date()
		//front
		fAirVolume = note.fAirVolume
		fCompSetting = note.fCompression
		fHSCSetting = note.fHSC
		fLSCSetting = note.fLSC
		fReboundSetting = note.fRebound
		fHSRSetting = note.fHSR
		fLSRSetting = note.fLSR
		fTokenSetting = note.fTokens
		fSagSetting = note.fSag
		fTirePressure = note.fTirePressure
		//rear
		rSpring = note.rAirSpring
		rCompSetting = note.rCompression
		rHSCSetting = note.rHSC
		rLSCSetting = note.rLSC
		rReboundSetting = note.rRebound
		rHSRSetting = note.rHSR
		rLSRSetting = note.rLSR
		rTokenSetting = note.rTokens
		rSagSetting = note.rSag
		rTirePressure = note.rTirePressure
	}
	
	func saveNote() {
		
	}
	
	func updateNote() {
		
	}
	
}
