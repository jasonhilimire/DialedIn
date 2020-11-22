//
//  EditNoteDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct EditNoteDetailView: View {
	
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	// Get All the bikes for the PickerView
	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>
	
	@ObservedObject var frontSetup = NoteFrontSetupModel()
	@ObservedObject var rearSetup = NoteRearSetupModel()
	@ObservedObject var keyboard = KeyboardObserver()
	
	@State private var createdInitialBike = false
	@State private var bikeNameIndex = 0
	@State var bikeName = ""
	@State private var noteText = ""
	@State private var date = Date()
	@State private var rating = 0
	@State private var isFavorite = false
	@State private var toggleNoteDetail = true
	@State private var saveText = "Save"
	
	
	let note: Notes
	
	var body: some View {
		NavigationView {
			VStack {
				Form{
					Section(header: Text("Ride Details")){
						
							Text("\(note.bike?.name ?? "Unknown Bike")")
								.fontWeight(.thin)
						
						DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
							Text("Select a date:")
								.fontWeight(.thin)
						}
						Toggle(isOn: $toggleNoteDetail.animation(), label: {Text("Add Note Details").fontWeight(.thin)})
						if toggleNoteDetail == true {
							HStack {
								Text("Note:").fontWeight(.thin)
								
								TextEditor(text: self.$noteText)
									.foregroundColor(.gray)
									.background(Color("TextEditBackgroundColor"))
									.cornerRadius(8)
							}
							HStack {
								RatingView(rating: $rating)
								Spacer()
								Text("Favorite:").fontWeight(.thin)
								FavoritesView(favorite: self.$isFavorite)
							}
						}
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
						AddNoteFrontSetupView(front: frontSetup)
					}
					
					// MARK: - Rear Setup -
					Section(header:
								HStack {
									Image("shock-absorber")
										.resizable()
										.frame(width: 50, height: 50)
										.scaledToFit()
									Text("Rear Suspension Details")
								}
					){
						AddNoteRearSetupView(rear: rearSetup)
					}
				} // end form
				.onAppear(perform: {self.setup()}) // change to onReceive??
				.navigationBarTitle("Dialed In", displayMode: .inline)
				
				Button(action: {
					self.saveNote()
					
					withAnimation(.linear(duration: 0.05), {
						self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
					})
					
					try? self.moc.save()
					hapticSuccess()
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
						self.presentationMode.wrappedValue.dismiss()
					}
				}) {
					SaveButtonView(buttonText: $saveText)
				}.buttonStyle(OrangeButtonStyle())
			}
		}
		// Dismisses the keyboard
		.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
		
	}
	
	// MARK: - FUNCTIONS -
	
	
	
	func saveNote() {
		var bikes : [Bike] = []
		let fetchRequest = Bike.selectedBikeFetchRequest(filter: bikeName)
		do {
			bikes = try moc.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		
		let bike = bikes[0]
		
		let newNote = Notes(context: self.moc)
		newNote.note = self.noteText
		newNote.rating = Int16(self.rating)
		newNote.date = self.date
		newNote.isFavorite = self.isFavorite
		
		// FRONT
		newNote.fAirVolume = Double(self.frontSetup.lastFAirSetting)
		newNote.fCompression = self.frontSetup.lastFCompSetting
		newNote.fHSC = self.frontSetup.lastFHSCSetting
		newNote.fLSC = self.frontSetup.lastFLSCSetting
		newNote.fRebound = self.frontSetup.lastFReboundSetting
		newNote.fHSR = self.frontSetup.lastFHSRSetting
		newNote.fLSR = self.frontSetup.lastFLSRSetting
		newNote.fTokens = self.frontSetup.lastFTokenSetting
		newNote.fSag = self.frontSetup.lastFSagSetting
		newNote.fTirePressure = self.frontSetup.lastFTirePressure
		newNote.bike?.hasRearShock = self.rearSetup.hasRear
		
		// REAR
		newNote.rAirSpring = self.rearSetup.lastRAirSpringSetting
		newNote.rCompression = self.rearSetup.lastRCompSetting
		newNote.rHSC = self.rearSetup.lastRHSCSetting
		newNote.rLSC = self.rearSetup.lastRLSCSetting
		newNote.rRebound = self.rearSetup.lastRReboundSetting
		newNote.rHSR = self.rearSetup.lastRHSRSetting
		newNote.rLSR = self.rearSetup.lastRLSRSetting
		// TODO: something here for a coil???
		newNote.rTokens = self.rearSetup.lastRTokenSetting
		newNote.rSag = self.rearSetup.lastRSagSetting
		newNote.rTirePressure = self.rearSetup.lastRTirePressure
		
		bike.addToSetupNotes(newNote)
		
	}
	
	func setup() {
		rating = Int(self.note.rating)
		noteText = self.note.note ?? ""
		bikeName = self.note.bike?.name ?? "Unknown Bike"
		
		// TODO: values are getting set for frontsetup - but they are not reflecting on the screen properly
		print("bike name is: \(bikeName)")
		
		frontSetup.bikeName = bikeName
		print("front setup air = \(frontSetup.lastFAirSetting)")
		
		rearSetup.bikeName = self.bikeName
		rearSetup.getLastRearSettings()
		
	}
}


