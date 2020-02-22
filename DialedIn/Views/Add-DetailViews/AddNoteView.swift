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
    @State private var bikeName = ""
    @State private var note = ""
    @State private var date = Date()
    @State private var rating = 3
    

    @State private var fCompressionToggle = true
    @State private var fReboundToggle = true
    @State private var rCompressionToggle = true
    @State private var rReboundToggle = true
    @State private var isCoil = false
    
    let bike: Bike
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    Section(header: Text("Ride Details")){
//                        BikePickerView(bikeNameIndex: $bikeNameIndex)
//                        .onAppear(perform: {self.setToggles()})
                        
//TODO: bug in the picker where its not updating the text on the Picker Line
                        Text("Selected Bike is: \(bike.name ?? "Unknown Bike")").foregroundColor(.red)
                            
                        
                        TextField("Note", text: $note )
                        DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                            Text("Select a date")
                        }
                        RatingView(rating: $rating)
                    }
                    
                    
                    // MARK: - FRONT SETUP -
                    Section(header: Text("Front Suspension Details")){
                            // AirPressure
                        HStack{
                            Text("PSI: \(self.frontSetup.lastFAirSetting, specifier: "%.1f")")
                            Slider(value: $frontSetup.lastFAirSetting, in: 45...120, step: 0.5)
                        }
                            // Tokens
                        Stepper(value: $frontSetup.lastFTokenSetting, in: 0...6, label: {Text("Tokens: \(self.frontSetup.lastFTokenSetting)")})
                            
                            //Compression
                            if fCompressionToggle == true {
                                Stepper(value: $frontSetup.lastFHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.frontSetup.lastFHSCSetting)")})
                                Stepper(value: $frontSetup.lastFLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.frontSetup.lastFLSCSetting)")})
                            } else {
                                Stepper(value: $frontSetup.lastFCompSetting, in: 0...25, label: {Text("Compression: \(self.frontSetup.lastFCompSetting)")})
                            }
                            
                            // Rebound

                            if fReboundToggle == true {
                                Stepper(value: $frontSetup.lastFHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.frontSetup.lastFHSRSetting)")})
                                Stepper(value: $frontSetup.lastFLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.frontSetup.lastFLSRSetting)")})
                            } else {
                                Stepper(value: $frontSetup.lastFReboundSetting, in: 0...25, label: {Text("Rebound: \(self.frontSetup.lastFReboundSetting)")})
                            }
                    }
                       
                   // MARK: - Rear Setup
                       Section(header: Text("Rear Suspension Details")){
                        // Air - Coil
                            if isCoil == false {
                            HStack{
                                Text("PSI: \(self.rearSetup.lastRAirSpringSetting, specifier: "%.0f")")
                                Slider(value: $rearSetup.lastRAirSpringSetting, in: 100...350, step: 1.0)
                               }
                            } else {
                                HStack{
                                    Text("Spring: \(self.rearSetup.lastRAirSpringSetting, specifier: "%.0f")")
                                    Slider(value: $rearSetup.lastRAirSpringSetting, in: 300...700, step: 25)
                                }
                            }
                        //Tokens
                        Stepper(value: $rearSetup.lastRTokenSetting, in: 0...6, label: {Text("Tokens: \(self.rearSetup.lastRTokenSetting)")})
                        //Compression
                            if rCompressionToggle == true {
                                Stepper(value: $rearSetup.lastRHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.rearSetup.lastRHSCSetting)")})
                                Stepper(value: $rearSetup.lastRLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.rearSetup.lastRLSCSetting)")})
                            } else {
                                Stepper(value: $rearSetup.lastRCompSetting, in: 0...25, label: {Text("Compression: \(self.rearSetup.lastRCompSetting)")})
                            }
                            
                        // Rebound
                            if rReboundToggle == true {
                                Stepper(value: $rearSetup.lastRHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.rearSetup.lastRHSRSetting)")})
                                Stepper(value: $rearSetup.lastRLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.rearSetup.lastRLSRSetting)")})
                            } else {
                                Stepper(value: $rearSetup.lastRReboundSetting, in: 0...20, label: {Text("Rebound: \(self.rearSetup.lastRReboundSetting)")})
                            }
                       }
                } // end form
                    
                    .navigationBarTitle("DialedIn")
                
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
        newNote.bike?.name = bike.name
        newNote.fAirVolume = Double(self.frontSetup.lastFAirSetting)
        newNote.fCompression = self.frontSetup.lastFCompSetting
        newNote.fHSC = self.frontSetup.lastFHSCSetting
        newNote.fLSC = self.frontSetup.lastFLSCSetting
        newNote.fRebound = self.frontSetup.lastFReboundSetting
        newNote.fHSR = self.frontSetup.lastFHSRSetting
        newNote.fLSR = self.frontSetup.lastFLSRSetting
        newNote.fTokens = self.frontSetup.lastFTokenSetting
        
        newNote.rAirSpring = self.rearSetup.lastRAirSpringSetting
        newNote.rCompression = self.rearSetup.lastRCompSetting
        newNote.rHSC = self.rearSetup.lastRHSCSetting
        newNote.rLSC = self.rearSetup.lastRLSCSetting
        newNote.rRebound = self.rearSetup.lastRReboundSetting
        newNote.rHSR = self.rearSetup.lastRHSRSetting
        newNote.rLSR = self.rearSetup.lastRLSRSetting
        newNote.rTokens = self.rearSetup.lastRTokenSetting
    }
    
    func setToggles() {
        self.fCompressionToggle = self.bikes[bikeNameIndex].frontSetup?.dualCompression ?? true
        self.fReboundToggle = self.bikes[bikeNameIndex].frontSetup?.dualRebound ?? true
        
        self.rCompressionToggle = self.bikes[bikeNameIndex].rearSetup?.dualCompression ?? true
        self.rReboundToggle = self.bikes[bikeNameIndex].rearSetup?.dualRebound ?? true
        self.isCoil = self.bikes[bikeNameIndex].rearSetup?.isCoil ?? false
        
        
        // TODO: BUG HERE DURING SCROLLING WHERE showing the  picker again resets all the toggles because nothing has been actually saved
        // When returning from Picker View .onAppear Update the model
        bikeName = bike.name ?? "Unknown"
        frontSetup.bikeName = bikeName
        frontSetup.getLastFrontSettings()
        
        rearSetup.bikeName = bikeName
        rearSetup.getLastRearSettings()
    }
    
}

//struct AddNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteView()
//    }
//}
