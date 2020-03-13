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
							
						//TODO: bug in the picker where its not updating the text on the Picker Line in Beta only
						
//						Text("Selected Bike is: \(self.bikes[bikeNameIndex].name ?? "Unknown Bike")").foregroundColor(.red).bold()
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
        newNote.bike?.name = self.bikes[bikeNameIndex].name
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
		newNote.bike?.frontSetup?.lowerLastServiced = self.frontSetup.lastLowerService
		newNote.bike?.frontSetup?.lasfFullService = self.frontSetup.lastFullService
        
        newNote.bike?.rearSetup = RearShock(context: self.moc)
        newNote.bike?.rearSetup?.dualCompression = self.rearSetup.rComp
        newNote.bike?.rearSetup?.dualRebound = self.rearSetup.rReb
        newNote.bike?.rearSetup?.isCoil = self.rearSetup.coil
		newNote.bike?.rearSetup?.lastAirCanService = self.rearSetup.lastAirServ
		newNote.bike?.rearSetup?.lastFullService = self.rearSetup.lastFullServ
        
    }
    
    func setup() {
        bikeName = bikes[bikeNameIndex].name ?? "Unknown"
        frontSetup.bikeName = bikeName
        frontSetup.getLastFrontSettings()
        
        rearSetup.bikeName = bikeName
        rearSetup.getLastRearSettings()
		
        // these shoudl be setup via the model
        self.frontSetup.fComp = self.bikes[bikeNameIndex].frontSetup?.dualCompression ?? true
        self.frontSetup.fReb = self.bikes[bikeNameIndex].frontSetup?.dualRebound ?? true
        
        self.rearSetup.rComp = self.bikes[bikeNameIndex].rearSetup?.dualCompression ?? true
        self.rearSetup.rReb = self.bikes[bikeNameIndex].rearSetup?.dualRebound ?? true
        self.rearSetup.coil = self.bikes[bikeNameIndex].rearSetup?.isCoil ?? false
        self.rearSetup.hasRear = self.bikes[bikeNameIndex].hasRearShock

    }
    
}

//struct AddNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteView()
//    }
//}
