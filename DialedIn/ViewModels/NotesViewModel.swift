//
//  NotesViewModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/1/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine

public class NotesViewModel: ObservableObject {
	// Initializer?
	
	@Published var id = UUID()
	@Published var date = Date()
	@Published var fAirVolume: Double = 0.0
	@Published var fCompression: Int16 = 0
	@Published var fHSC: Int16 = 0
	@Published var fHSR: Int16 = 0
	@Published var fLSC: Int16 = 0
	@Published var fLSR: Int16 = 0
	@Published var fRebound: Int16 = 0
	@Published var fSag: Int16 = 0
	@Published var fTirePressure: Double = 0.0
	@Published var fTokens: Int16 = 0
	@Published var isFavorite: Bool = false
	@Published var note: String = ""
	@Published var rating: Int16 = 0
	@Published var rAirSpring: Double = 0.0
	@Published var rCompression: Int16 = 0
	@Published var rHSC: Int16 = 0
	@Published var rHSR: Int16 = 0
	@Published var rLSC: Int16 = 0
	@Published var rLSR: Int16 = 0
	@Published var rRebound: Int16 = 0
	@Published var rSag: Int16 = 0
	@Published var rTirePressure: Double = 0.0
	@Published var rTokens: Int16 = 0
	
	//Create
	
	class func newNote() -> Notes{
		let moc = PersistentCloudKitContainer.context
		let newNote = Notes(context: moc)
		return newNote
	}
	
	
	// TODO: Should these be even smaller?? -- how to handle the optionals if using or not using Dual Comp/Rebound also need to return a note?
	class func createFrontNote(date: Date, fAirVolume: Double, fCompression: Int16, fHSC: Int16, fHSR: Int16, fLSC: Int16, fLSR: Int16, fRebound: Int16, fSag: Int16, fTirePressure: Double, fTokens: Int16) {
		let note = NotesViewModel.newNote()
		note.date = date
		note.fAirVolume = fAirVolume
		note.fCompression = fCompression
		note.fHSC = fHSC
		note.fLSC = fLSC
		note.fRebound = fRebound
		note.fHSR = fHSR
		note.fLSR = fLSR
		note.fSag = fSag
		note.fTirePressure = fTirePressure
		note.fTokens = fTokens
	}
	
	class func createRearNote(date: Date, rAirSpring: Double, rCompression: Int16, rHSC: Int16, rHSR: Int16, rLSC: Int16, rLSR: Int16, rRebound: Int16, rSag: Int16, rTirePressure: Double, rTokens: Int16) {
		let note = NotesViewModel.newNote()
		note.date = date
		note.rAirSpring = rAirSpring
		note.rCompression = rCompression
		note.rHSC = rHSC
		note.rLSC = rLSC
		note.rRebound = rRebound
		note.rHSR = rHSR
		note.rLSR = rLSR
		note.rSag = rSag
		note.rTirePressure = rTirePressure
		note.rTokens = rTokens
		
	}
	
	class func createNoteDetails(isFavorite: Bool, noteText: String, rating: Int16) {
		let note = NotesViewModel.newNote()
		note.isFavorite = isFavorite
		note.note = noteText
		note.rating = rating
	}
	
	class func createNote() -> Notes {
		let note = NotesViewModel.newNote()
		note.id = UUID()
		//TODO add above functions here
		// createFrontNote()
		// createRearNote()
		// createNoteDetails
		PersistentCloudKitContainer.saveContext()
		return note
	}
	
	
	
	//Read
	
	//Update
	
	//Delete
	
}
