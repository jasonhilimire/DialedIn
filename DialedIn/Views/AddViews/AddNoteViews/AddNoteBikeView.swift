//
//  AddNoteBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/25/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import Combine

struct AddNoteBikeView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
		
	@ObservedObject var frontSetup = NoteFrontSetupModel()
	@ObservedObject var rearSetup = NoteRearSetupModel()
	
	@State private var createdInitialBike = false
	@State private var bikeNameIndex = 0
	@State private var bikeName = ""
	@State private var note = ""
	@State private var date = Date()
	@State private var rating = 3
	
	let bike: Bike

	var body: some View {
		NavigationView {
			VStack {
				Form{
					Section(header: Text("Ride Details")){
						Text("Bike: \(self.bike.name ?? "Unknown Bike")").foregroundColor(.red).bold()
						TextField("Note", text: $note )
						DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
							Text("Select a date")
						}
						RatingView(rating: $rating)
					}
					
					// MARK: - FRONT SETUP -
					Section(header:
						HStack {
							Image("bicycle-fork")
								.resizable()
								.frame(width: 50, height: 50)
								.scaledToFit()
							Text("Front Suspension Details")
						}
						
					){
						AddNoteFrontSetupView(frontsetup: frontSetup)
					}
					
					// MARK: - Rear Setup
					Section(header:
						HStack {
							Image("shock-absorber")
								.resizable()
								.frame(width: 50, height: 50)
								.scaledToFit()
							Text("Rear Suspension Details")
						}
					){
						AddNoteRearSetupView(rearSetup: rearSetup)
					}
				} // end form
					.onAppear(perform: {self.setup()})
					.navigationBarTitle("DialedIn", displayMode: .inline)
				
				Button(action: {
					//dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()
					self.saveNote()
					
					try? self.moc.save()
				}) {
					SaveButtonView()
				}
			}
		}
	}
	
	// MARK: - FUNCTIONS
	
	func saveNote() {
		let newNote = Notes(context: self.moc)
		newNote.note = self.note
		newNote.rating = Int16(self.rating)
		newNote.date = self.date
		
		newNote.bike = Bike(context: self.moc)
		newNote.bike?.name = self.bike.name
		newNote.fAirVolume = Double(self.frontSetup.lastFAirSetting)
		newNote.fCompression = self.frontSetup.lastFCompSetting
		newNote.fHSC = self.frontSetup.lastFHSCSetting
		newNote.fLSC = self.frontSetup.lastFLSCSetting
		newNote.fRebound = self.frontSetup.lastFReboundSetting
		newNote.fHSR = self.frontSetup.lastFHSRSetting
		newNote.fLSR = self.frontSetup.lastFLSRSetting
		newNote.fTokens = self.frontSetup.lastFTokenSetting
		newNote.fSag = self.frontSetup.lastFSagSetting
		newNote.bike?.hasRearShock = self.rearSetup.hasRear
		
		newNote.rAirSpring = self.rearSetup.lastRAirSpringSetting
		newNote.rCompression = self.rearSetup.lastRCompSetting
		newNote.rHSC = self.rearSetup.lastRHSCSetting
		newNote.rLSC = self.rearSetup.lastRLSCSetting
		newNote.rRebound = self.rearSetup.lastRReboundSetting
		newNote.rHSR = self.rearSetup.lastRHSRSetting
		newNote.rLSR = self.rearSetup.lastRLSRSetting
		newNote.rTokens = self.rearSetup.lastRTokenSetting
		newNote.rSag = self.rearSetup.lastRSagSetting
		
		newNote.bike?.frontSetup = Fork(context: self.moc)
		newNote.bike?.frontSetup?.dualCompression = self.frontSetup.fComp
		newNote.bike?.frontSetup?.dualRebound = self.frontSetup.fReb
		
		newNote.bike?.rearSetup = RearShock(context: self.moc)
		newNote.bike?.rearSetup?.dualCompression = self.rearSetup.rComp
		newNote.bike?.rearSetup?.dualRebound = self.rearSetup.rReb
		newNote.bike?.rearSetup?.isCoil = self.rearSetup.coil
		
	}
	
	func setup() {
		bikeName = bike.name ?? "Unknown"
		print("Setup ran")
		print(bikeName)
		
		frontSetup.bikeName = bikeName
		frontSetup.getLastFrontSettings()
		
		rearSetup.bikeName = bikeName
		rearSetup.getLastRearSettings()
		print(bike.rearSetup)
//		self.frontSetup.fComp = self.bike.frontSetup?.dualCompression ?? true
//		self.frontSetup.fReb = self.bike.frontSetup?.dualRebound ?? true
//		
//		self.rearSetup.rComp = self.bike.rearSetup?.dualCompression ?? true
//		self.rearSetup.rReb = self.bike.rearSetup?.dualRebound ?? true
//		self.rearSetup.coil = self.bike.rearSetup?.isCoil ?? false
//		self.rearSetup.hasRear = self.bike.hasRearShock
		
	}
}

//struct AddNoteBikeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteBikeView()
//    }
//}
