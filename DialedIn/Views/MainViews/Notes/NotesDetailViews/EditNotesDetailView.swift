//
//  EditNotesDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct EditNotesDetailView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	// Get All the bikes for the PickerView
	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>
	
	@ObservedObject var frontSetup = NoteFrontSetupModel()
	@ObservedObject var rearSetup = NoteRearSetupModel()
	@ObservedObject var keyboard = KeyboardObserver()
	
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
						Text("\(self.bikeName)")
							.fontWeight(.bold)
						
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
						Text("PSI from note: \(note.fAirVolume, specifier: "%.1f")").fontWeight(.thin)
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
				}.buttonStyle(OrangeButtonStyle())
			}
		}
		// Dismisses the keyboard
		.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
		
	}
	
	// MARK: - FUNCTIONS -
	
	func updateNote() {

		note.note = self.noteText
		note.rating = Int16(self.rating)
		note.date = self.date
		note.isFavorite = self.isFavorite
		
		// FRONT
		note.fAirVolume = Double(self.frontSetup.lastFAirSetting)
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
		/*
		var bikeArray: [Bike] = []
		do {
			let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bike")
			let fetch = try moc.fetch(request)
			bikeArray = fetch as! [Bike]
		} catch let error as NSError {
			print("get all Bikes \(error)")
		}
		

		for bike: Bike in bikeArray {
			if let index = bikeArray.firstIndex(of: bike) {
				print(" >> \(String(describing: bike.name)) index = \(index)")
				// how to match that index though!!!
			}
			
		}
		
		*/
		
		// TODO: Edit Models to get current note Data into SetupViews???
		frontSetup.bikeName = bikeName
		frontSetup.getCurrentNoteFrontSettings(note: note)
		
		rearSetup.bikeName = bikeName
		rearSetup.getLastRearSettings()
		
		// below are setting correctly
		bikeName = note.bike?.name ?? "Unknown"
		date = note.date ?? Date()
		noteText = note.note ?? ""
		isFavorite = note.isFavorite
		rating = Int(note.rating)
		
	}
}


