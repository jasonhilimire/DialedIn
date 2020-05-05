//
//  AddNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteView: View {
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    // Get All the bikes for the PickerView
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest())
    var bikes: FetchedResults<Bike>
    
    @ObservedObject var frontSetup = NoteFrontSetupModel()
    @ObservedObject var rearSetup = NoteRearSetupModel()

    @State private var createdInitialBike = false
    @State private var bikeNameIndex = 0
    @State var bikeName = ""
    @State private var note = ""
    @State private var date = Date()
    @State private var rating = 3
	
    
    var body: some View {
        NavigationView {
			VStack {
				Form{
					Section(header: Text("Ride Details")){
						if bikes.count == 1 {
							Text("\(self.bikes[bikeNameIndex].name!)")
						} else {
							BikePickerView(bikeNameIndex: $bikeNameIndex)
						}
						
						// Not sure happy with how this works- no placeholder text so using HSTACK to show Note:, but also return key is actual return and doesnt dismiss keyboard
//						HStack {
//							Text("Note:")
//							TextView(text: $note)
//						}
					
						TextField("Enter Note", text: $note )
						DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
							Text("Select a date:")
						
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
						AddNoteFrontSetupView(front: frontSetup)
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
						AddNoteRearSetupView(rear: rearSetup)
					}
				} // end form
					.onAppear(perform: {self.setup()}) // change to onReceive??
					.navigationBarTitle("Dialed In", displayMode: .inline)
				
				Button(action: {
					//dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()
					self.saveNote()
					
					try? self.moc.save()
				}) {
					SaveButtonView()
				}.buttonStyle(OrangeButtonStyle())
			}
        }
			// dismisses keyboard with the slightest scroll- so far best answer to dismissing and easy to implement-- but breaks the sliders :(
//			.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
		
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
        newNote.note = self.note
        newNote.rating = Int16(self.rating)
        newNote.date = self.date

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
		
		bike.addToSetupNotes(newNote)
  
    }
    
    func setup() {
        bikeName = bikes[bikeNameIndex].name ?? "Unknown"
        frontSetup.bikeName = bikeName
        frontSetup.getLastFrontSettings()
        
        rearSetup.bikeName = bikeName
        rearSetup.getLastRearSettings()

    }
    
}
