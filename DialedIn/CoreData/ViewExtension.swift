//
//  ViewExtension.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

// MARK: - View Extensions -

//https://www.raywenderlich.com/7586-multiple-managed-object-contexts-with-core-data-tutorial#toc-anchor-009

extension View {
	
	func newNote(moc: NSManagedObjectContext) -> Notes {
		let newNote = Notes(context: moc)
		return newNote
	}
	
	func createNewNote(moc: NSManagedObjectContext , note: String, rating: Int, date: Date) {
		let createdNote = newNote(moc: moc)
		createdNote.note = note
		createdNote.rating = Int16(rating)
		createdNote.date = date
		
	}
	func createBike(moc: NSManagedObjectContext, name: String, fAir: Double, hasRear: Bool) {
		let createdNote = newNote(moc: moc)
		createdNote.bike = Bike(context: moc)
		createdNote.bike?.name = name
		createdNote.fAirVolume = fAir
		createdNote.bike?.hasRearShock = hasRear
	}
	
	
	
	
	//		newNote.fCompression = frontSetup.lastFCompSetting
	//		newNote.fHSC = frontSetup.lastFHSCSetting
	//		newNote.fLSC = frontSetup.lastFLSCSetting
	//		newNote.fRebound = frontSetup.lastFReboundSetting
	//		newNote.fHSR = frontSetup.lastFHSRSetting
	//		newNote.fLSR = frontSetup.lastFLSRSetting
	//		newNote.fTokens = frontSetup.lastFTokenSetting
	//		newNote.fSag = frontSetup.lastFSagSetting
	
	//
	//		newNote.rAirSpring = rearSetup.lastRAirSpringSetting
	//		newNote.rCompression = rearSetup.lastRCompSetting
	//		newNote.rHSC = rearSetup.lastRHSCSetting
	//		newNote.rLSC = rearSetup.lastRLSCSetting
	//		newNote.rRebound = rearSetup.lastRReboundSetting
	//		newNote.rHSR = rearSetup.lastRHSRSetting
	//		newNote.rLSR = rearSetup.lastRLSRSetting
	//		newNote.rTokens = rearSetup.lastRTokenSetting
	//		newNote.rSag = rearSetup.lastRSagSetting
	//
	//		newNote.bike?.frontSetup = Fork(context: moc)
	//		newNote.bike?.frontSetup?.dualCompression = frontSetup.fComp
	//		newNote.bike?.frontSetup?.dualRebound = frontSetup.fReb
	//
	//		newNote.bike?.rearSetup = RearShock(context: moc)
	//		newNote.bike?.rearSetup?.dualCompression = rearSetup.rComp
	//		newNote.bike?.rearSetup?.dualRebound = rearSetup.rReb
	//		newNote.bike?.rearSetup?.isCoil = rearSetup.coil
	
}

