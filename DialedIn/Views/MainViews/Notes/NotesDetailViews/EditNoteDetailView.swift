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
	@ObservedObject var noteModel = NoteModel()
	
	@State private var createdInitialBike = false
	@State private var bikeNameIndex = 0
	@State var bikeName = ""
	@State private var noteText = ""
	@State private var date = Date()
	@State private var rating = 0
	@State private var isFavorite = false
	@State private var toggleNoteDetail = true
	@State private var saveText = "Save"
	
	@State private var isEdit = true
	
	var haptic = UIImpactFeedbackGenerator(style: .light)
	
	
	let note: Notes
	
	//  MARK: - BODY -
	var body: some View {
		NavigationView {
			VStack {
				Form{
//TODO:  MAKE THIS SECTION ITS OWN VIEW - REUSABLE for ADD && EDITDETAIL dont forget bikepickerview from addnoteview
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
					
					AddNoteFrontSetupView(front: frontSetup, isDetailEdit: $isEdit, note: note)
					
					// MARK: - REAR SETUP -

					AddNoteRearSetupView(rear: rearSetup, note: note)
					
				} // end form
				.onAppear(perform: {self.setup()})

	
				.navigationBarTitle("Dialed In", displayMode: .inline)
				
				Button(action: {
					self.updateNote()
					
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
				}.buttonStyle(OrangeButtonStyle()).padding(.horizontal)
			}
		}
		// Dismisses the keyboard not sure why the standard doesnt work, but whatever
//		.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
		.onTapGesture { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
		
	}
	
	// MARK: - FUNCTIONS -
	
	// TODO: USING isEDIT flag (update so its binding from NotesDetail) add the save function here, update setup
	
	func updateNote() {
		note.note = self.noteText
		note.rating = Int16(self.rating)
		note.date = self.date
		note.isFavorite = self.isFavorite
		
		// FRONT
		note.fAirVolume = self.frontSetup.lastFAirSetting
		note.fCompression = self.frontSetup.lastFCompSetting
		note.fHSC = self.frontSetup.lastFHSCSetting
		note.fLSC = self.frontSetup.lastFLSCSetting
		note.fRebound = self.frontSetup.lastFReboundSetting
		note.fHSR = self.frontSetup.lastFHSRSetting
		note.fLSR = self.frontSetup.lastFLSRSetting
		note.fTokens = self.frontSetup.lastFTokenSetting
		note.fSag = self.frontSetup.lastFSagSetting
		note.fTirePressure = self.frontSetup.lastFTirePressure
		note.bike?.hasRearShock = self.rearSetup.hasRear
		
		// REAR
		note.rAirSpring = self.rearSetup.lastRAirSpringSetting
		note.rCompression = self.rearSetup.lastRCompSetting
		note.rHSC = self.rearSetup.lastRHSCSetting
		note.rLSC = self.rearSetup.lastRLSCSetting
		note.rRebound = self.rearSetup.lastRReboundSetting
		note.rHSR = self.rearSetup.lastRHSRSetting
		note.rLSR = self.rearSetup.lastRLSRSetting
		// TODO: something here for a coil???
		note.rTokens = self.rearSetup.lastRTokenSetting
		note.rSag = self.rearSetup.lastRSagSetting
		note.rTirePressure = self.rearSetup.lastRTirePressure
	}
	
	func setup() {
		noteModel.getNoteModel(note: note)
		rating = Int(noteModel.noteRating)
		noteText = noteModel.noteText
		isFavorite = noteModel.noteFavorite
		bikeName = self.note.bike?.name ?? "Unknown Bike"
		date = note.date ?? Date()
		frontSetup.bikeName = self.bikeName
//		frontSetup.getNoteFrontSettings(note: note)
		rearSetup.bikeName = self.bikeName
		rearSetup.getNoteRearSettings(note: note)
		print("EditNoteDetailView Setup ran")
	}
}


