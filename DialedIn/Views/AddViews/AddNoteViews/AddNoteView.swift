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
    

    @State private var fCompressionToggle = true
    @State private var fReboundToggle = true

    @State private var rCompressionToggle = true
    @State private var rReboundToggle = true
    @State private var isCoil = false
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    Section(header: Text("Ride Details")){
                        BikePickerView(bikeNameIndex: $bikeNameIndex)
                        .onAppear(perform: {self.setup()}) // change to onReceive??
                
//TODO: bug in the picker where its not updating the text on the Picker Line
                        Text("Selected Bike is: \(self.bikes[bikeNameIndex].name ?? "Unknown Bike")").foregroundColor(.red).bold()
                        TextField("Note", text: $note )
                        DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                            Text("Select a date")
                        }
                        RatingView(rating: $rating)
                    }
                    
                    
                    // MARK: - FRONT SETUP -
                    Section(header: Text("Front Suspension Details")){
                        AddNoteFrontSetupView(frontsetup: frontSetup)
                    }
                       
                   // MARK: - Rear Setup
                       Section(header: Text("Rear Suspension Details")){
                        AddNoteRearSetupView(rearSetup: rearSetup)
                       }
                } // end form
                    
                    .navigationBarTitle("DialedIn", displayMode: .inline)
                
                Button(action: {
                    //dismisses the sheet
                    self.presentationMode.wrappedValue.dismiss()
                    self.saveNote()
                    
                    try? self.moc.save()
                }) {
                    SaveButtonView()
                }
//                .disabled(bikeName == "")
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
        newNote.bike?.name = self.bikes[bikeNameIndex].name
        newNote.fAirVolume = Double(self.frontSetup.lastFAirSetting)
        newNote.fCompression = self.frontSetup.lastFCompSetting
        newNote.fHSC = self.frontSetup.lastFHSCSetting
        newNote.fLSC = self.frontSetup.lastFLSCSetting
        newNote.fRebound = self.frontSetup.lastFReboundSetting
        newNote.fHSR = self.frontSetup.lastFHSRSetting
        newNote.fLSR = self.frontSetup.lastFLSRSetting
        newNote.fTokens = self.frontSetup.lastFTokenSetting
//        newNote.bike?.hasRearShock = self.
        
        newNote.rAirSpring = self.rearSetup.lastRAirSpringSetting
        newNote.rCompression = self.rearSetup.lastRCompSetting
        newNote.rHSC = self.rearSetup.lastRHSCSetting
        newNote.rLSC = self.rearSetup.lastRLSCSetting
        newNote.rRebound = self.rearSetup.lastRReboundSetting
        newNote.rHSR = self.rearSetup.lastRHSRSetting
        newNote.rLSR = self.rearSetup.lastRLSRSetting
        newNote.rTokens = self.rearSetup.lastRTokenSetting
        
        newNote.bike?.frontSetup = Fork(context: self.moc)
        newNote.bike?.frontSetup?.dualCompression = self.fCompressionToggle
        newNote.bike?.frontSetup?.dualRebound = self.fReboundToggle
        
        newNote.bike?.rearSetup = RearShock(context: self.moc)
        newNote.bike?.rearSetup?.dualCompression = self.fCompressionToggle
        newNote.bike?.rearSetup?.dualRebound = self.rCompressionToggle
        newNote.bike?.rearSetup?.isCoil = self.isCoil
        
    }
    
    func setup() {
        // TODO: BUG HERE DURING SCROLLING WHERE showing the  picker again resets all the toggles because nothing has been actually saved
        // When returning from Picker View .onAppear Update the model
        bikeName = bikes[bikeNameIndex].name ?? "Unknown"
        frontSetup.bikeName = bikeName
        frontSetup.getLastFrontSettings()
        
        rearSetup.bikeName = bikeName
        rearSetup.getLastRearSettings()
        
        self.fCompressionToggle = self.bikes[bikeNameIndex].frontSetup?.dualCompression ?? true
        self.fReboundToggle = self.bikes[bikeNameIndex].frontSetup?.dualRebound ?? true
        
        self.rCompressionToggle = self.bikes[bikeNameIndex].rearSetup?.dualCompression ?? true
        self.rReboundToggle = self.bikes[bikeNameIndex].rearSetup?.dualRebound ?? true
        self.isCoil = self.bikes[bikeNameIndex].rearSetup?.isCoil ?? false
        
    }
    
}

//struct AddNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteView()
//    }
//}
