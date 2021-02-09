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


class NoteViewModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	// MARK: - Published Variables
	
	let didChange = PassthroughSubject<NoteViewModel, Never>()
	
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
	
	func getLastFrontNote(front: NoteFrontSetupModel) {
		fAirVolume = front.lastFAirSetting
		fCompSetting = front.lastFCompSetting
		fHSCSetting = front.lastFHSCSetting
		fLSCSetting = front.lastFLSCSetting
		fReboundSetting = front.lastFReboundSetting
		fHSRSetting = front.lastFHSRSetting
		fLSRSetting = front.lastFLSRSetting
		fTokenSetting = front.lastFTokenSetting
		fSagSetting = front.lastFSagSetting
		fTirePressure = front.lastFTirePressure
	}
	
	func getLastRearNote(front: NoteRearSetupModel) {
		rSpring = front.lastRAirSpringSetting
		rCompSetting = front.lastRCompSetting
		rHSCSetting = front.lastRHSCSetting
		rLSCSetting = front.lastRLSCSetting
		rReboundSetting = front.lastRReboundSetting
		rHSRSetting = front.lastRHSRSetting
		rLSRSetting = front.lastRLSRSetting
		rTokenSetting = front.lastRTokenSetting
		rSagSetting = front.lastRSagSetting
		rTirePressure = front.lastRTirePressure
	}
	
	func saveNote(bikeName: String) {
		let bike = fetchBike(for: bikeName)
		
		let newNote = Notes(context: self.managedObjectContext)
		newNote.note = self.noteText
		newNote.rating = Int16(self.noteRating)
		newNote.date = self.noteDate
		newNote.isFavorite = self.noteFavorite
		newNote.id = UUID()
		
		// FRONT
		newNote.fAirVolume = Double(self.fAirVolume)
		newNote.fCompression = self.fCompSetting
		newNote.fHSC = self.fHSCSetting
		newNote.fLSC = self.fLSCSetting
		newNote.fRebound = self.fReboundSetting
		newNote.fHSR = self.fHSRSetting
		newNote.fLSR = self.fLSRSetting
		newNote.fTokens = self.fTokenSetting
		newNote.fSag = self.fSagSetting
		newNote.fTirePressure = self.fTirePressure
		
		// REAR
		newNote.rAirSpring = self.rSpring
		newNote.rCompression = self.rCompSetting
		newNote.rHSC = self.rHSCSetting
		newNote.rLSC = self.rLSCSetting
		newNote.rRebound = self.rReboundSetting
		newNote.rHSR = self.rHSRSetting
		newNote.rLSR = self.rLSRSetting
		newNote.rTokens = self.rTokenSetting
		newNote.rSag = self.rSagSetting
		newNote.rTirePressure = self.rTirePressure
		
		bike.addToSetupNotes(newNote)
		
	}
	
	func updateNote() {
		
	}
	
}
