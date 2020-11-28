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
	
	@State private var isEdit = true
	
	var haptic = UIImpactFeedbackGenerator(style: .light)
	
	
	let note: Notes
	
	//  MARK: - BODY -
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
						AddNoteFrontSetupView(front: frontSetup, isDetailEdit: $isEdit, note: note)
						
//						VStack{
//							// AirPressure
//							HStack{
//								Text("PSI: \(psi, specifier: "%.1f")").fontWeight(.thin)
//								Slider(value: $psi, in: 45...120, step: 1.0)
//								Stepper(value: $psi, in: 45...120, step: 0.5, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.psi)").fontWeight(.thin)}).labelsHidden()
//
//							}
//						}
					}
					
					// MARK: - REAR SETUP -
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
		bikeName = self.note.bike?.name ?? "Unknown Bike"
		rating = Int(self.note.rating)
		noteText = self.note.note ?? ""
		isFavorite = self.note.isFavorite
		date = note.date ?? Date()
		frontSetup.bikeName = bikeName
		frontSetup.getNoteFrontSettings(note: note)
		
		
		// TODO: values are getting set for frontsetup - but they are not reflecting on the screen properly
		
		

		
		rearSetup.bikeName = self.bikeName
		rearSetup.getLastRearSettings()
		
	}
}


