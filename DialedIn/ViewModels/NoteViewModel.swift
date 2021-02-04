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
	
	@Published var noteText: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteRating: Int16 = 1 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteFavorite: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var fAirSetting: Double = 45.0 {
		didSet {
			didChange.send(self)
		}
	}
	
	
	func getNoteModel(note: Notes) {
		noteText = note.note ?? ""
		noteRating = note.rating
		noteFavorite = note.isFavorite
		fAirSetting = note.fAirVolume
	}
	
	
	func updateNoteDetails(note: Notes, noteText: String, rating: Int, date: Date, isFavorite: Bool) {
		note.note = noteText
		note.rating = Int16(rating)
		note.date = date
		note.isFavorite = isFavorite
		
	}
	
	func updateFrontNoteDetails(note: Notes, fAir: Double, fCompression: Int16, fHSC: Int16, fLSC: Int16, fRebound: Int16, fHSR: Int16, fLSR: Int16, fTokens: Int16, fSag: Int16, fTirePressure: Double
	) {
		note.fAirVolume = fAir
		note.fCompression = fCompression
		note.fHSC = fHSC
		note.fLSC = fLSC
		note.fRebound = fRebound
		note.fHSR = fHSR
		note.fLSR = fLSR
		note.fTokens = fTokens
		note.fSag = fSag
		note.fTirePressure = fTirePressure
	}

//
//		// REAR
//		note.rAirSpring = self.rearSetup.lastRAirSpringSetting
//		note.rCompression = self.rearSetup.lastRCompSetting
//		note.rHSC = self.rearSetup.lastRHSCSetting
//		note.rLSC = self.rearSetup.lastRLSCSetting
//		note.rRebound = self.rearSetup.lastRReboundSetting
//		note.rHSR = self.rearSetup.lastRHSRSetting
//		note.rLSR = self.rearSetup.lastRLSRSetting
//
//		note.rTokens = self.rearSetup.lastRTokenSetting
//		note.rSag = self.rearSetup.lastRSagSetting
//		note.rTirePressure = self.rearSetup.lastRTirePressure
	
	
}
