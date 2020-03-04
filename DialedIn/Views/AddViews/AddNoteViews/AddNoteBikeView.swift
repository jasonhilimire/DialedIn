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
	
	// Get All the bikes for the PickerView
	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>

		
	@ObservedObject var front = NoteFrontSetupModel()
	@ObservedObject var rear = NoteRearSetupModel()
	
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
						Text("Bike: \(self.bike.name ?? "Unknown Bike")").foregroundColor(.blue).bold()
						TextField("Note", text: $note )
						DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
							Text("Select a date")
						}
						RatingView(rating: $rating)
					}
					
					// MARK: - FRONT SETUP
					Section(header:
						HStack {
							Image("bicycle-fork")
								.resizable()
								.frame(width: 50, height: 50)
								.scaledToFit()
							Text("Front Suspension Details")
						}
						
					){
						AddNoteFrontSetupView(front: self.front)
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
						AddNoteRearSetupView(rear: self.rear)
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
	
	// MARK: - FUNCTIONS -
	
	func saveNote() {
		let newNote = Notes(context: self.moc)
		newNote.note = self.note
		newNote.rating = Int16(self.rating)
		newNote.date = self.date
		
		newNote.bike = Bike(context: self.moc)
		newNote.bike?.name = self.bike.name
		newNote.fAirVolume = Double(self.front.lastFAirSetting)
		newNote.fCompression = self.front.lastFCompSetting
		newNote.fHSC = self.front.lastFHSCSetting
		newNote.fLSC = self.front.lastFLSCSetting
		newNote.fRebound = self.front.lastFReboundSetting
		newNote.fHSR = self.front.lastFHSRSetting
		newNote.fLSR = self.front.lastFLSRSetting
		newNote.fTokens = self.front.lastFTokenSetting
		newNote.fSag = self.front.lastFSagSetting
		newNote.bike?.hasRearShock = self.rear.hasRear
		
		newNote.rAirSpring = self.rear.lastRAirSpringSetting
		newNote.rCompression = self.rear.lastRCompSetting
		newNote.rHSC = self.rear.lastRHSCSetting
		newNote.rLSC = self.rear.lastRLSCSetting
		newNote.rRebound = self.rear.lastRReboundSetting
		newNote.rHSR = self.rear.lastRHSRSetting
		newNote.rLSR = self.rear.lastRLSRSetting
		newNote.rTokens = self.rear.lastRTokenSetting
		newNote.rSag = self.rear.lastRSagSetting
		
		newNote.bike?.frontSetup = Fork(context: self.moc)
		newNote.bike?.frontSetup?.dualCompression = self.front.fComp
		newNote.bike?.frontSetup?.dualRebound = self.front.fReb
		
		newNote.bike?.rearSetup = RearShock(context: self.moc)
		newNote.bike?.rearSetup?.dualCompression = self.rear.rComp
		newNote.bike?.rearSetup?.dualRebound = self.rear.rReb
		newNote.bike?.rearSetup?.isCoil = self.rear.coil
		
		
	}
	
	func setup() {

		bikeName = self.bike.name ?? "Unknown bike"
		
		front.bikeName = bikeName
		front.getLastFrontSettings()
		
		print("after getlastFrsettings")
		
		rear.bikeName = bikeName
		rear.getLastRearSettings()

		// Should be in model?
		self.front.fComp = self.bike.frontSetup?.dualCompression ?? true
		self.front.fReb = self.bike.frontSetup?.dualRebound ?? true
		
		self.rear.rComp = self.bike.rearSetup?.dualCompression ?? true
		self.rear.rReb = self.bike.rearSetup?.dualRebound ?? true
		self.rear.coil = self.bike.rearSetup?.isCoil ?? false
		self.rear.hasRear = self.bike.hasRearShock
		
	}
}

//struct AddNoteBikeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteBikeView()
//    }
//}
