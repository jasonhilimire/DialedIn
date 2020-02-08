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
    @FetchRequest(entity: Bike.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Bike.name, ascending: true)
    ]) var bikes: FetchedResults<Bike>
    
    // Get Just the bike chosen from the Picker

    
    @State private var bikeName = ""
    @State private var note = ""
    @State private var date = Date()
    @State private var rating = 3
    
    @State private var fPSI = 45
    @State private var fHSC = Int()
    @State private var fLSC = Int()
    @State private var fComp = Int()
    @State private var fCompressionToggle = true
    @State private var fHSR = Int()
    @State private var fLSR = Int()
    @State private var fReb = Int()
    @State private var fReboundToggle = true
    @State private var fTokens = Int()
    
    @State private var rPSI = 150
    @State private var rHSC = Int()
    @State private var rLSC = Int()
    @State private var rComp = Int()
    @State private var rCompressionToggle = true
    @State private var rHSR = Int()
    @State private var rLSR = Int()
    @State private var rReb = Int()
    @State private var rReboundToggle = true
    @State private var rTokens = Int()
    
    
    
    //TODO: Fix
    var body: some View {
        NavigationView {
            VStack{
                Text("Add a Note")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.leading)
                    .padding([.top, .trailing])
                Form{
                    Section(header: Text("Ride Details")){
                            // Bug in picker view that cant reselect? after making a choice
                        Picker(selection: $bikeName, label: Text("Choose Bike")) {
                        ForEach(bikes, id: \.self) { bike in Text(bike.wrappedBikeName).tag(bike.wrappedBikeName)}
                        }
                        TextField("Note", text: $note )
                        DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                            Text("Select a date")
                        }
                        RatingView(rating: $rating)
                        }
                    Section(header: Text("Front Suspension Details")){
                            // AirPressure
                            Stepper(value: $fPSI, in: 45...120, label: {Text("PSI: \(self.fPSI)")})
                            // Tokens
                            Stepper(value: $fTokens, in: 0...6, label: {Text("Tokens: \(self.fTokens)")})
                            
                            //Compression
//                            Toggle(isOn: $fCompressionToggle.animation(), label: {Text("Dual Compression?")})
                            if fCompressionToggle == true {
                                Stepper(value: $fHSC, in: 0...25, label: {Text("High speed: \(self.fHSC)")})
                                Stepper(value: $fLSC, in: 0...25, label: {Text("Low speed: \(self.fLSC)")})
                            } else {
                                Stepper(value: $fComp, in: 0...20, label: {Text("Compression: \(self.fComp)")})
                            }
                            
                            // Rebound
//                            Toggle(isOn: $fReboundToggle.animation(), label: {Text("Dual Rebound?")})
                            if fReboundToggle == true {
                                Stepper(value: $fHSR, in: 0...25, label: {Text("High speed: \(self.fHSR)")})
                                Stepper(value: $fLSR, in: 0...25, label: {Text("Low speed: \(self.fLSR)")})
                            } else {
                                Stepper(value: $fReb, in: 0...25, label: {Text("Rebound: \(self.fReb)")})
                            }
                        }
                       
                       Section(header: Text("Rear Suspension Details")){
                            // Air Pressure
                            Stepper(value: $rPSI, in: 100...300, label: {Text("PSI: \(self.rPSI)")})
                            // Tokens
                            Stepper(value: $rTokens, in: 0...6, label: {Text("Tokens: \(self.rTokens)")})
                            //Compression
//                            Toggle(isOn: $rCompressionToggle.animation(), label: {Text("Dual Compression?")})
                            if rCompressionToggle == true {
                                Stepper(value: $rHSC, in: 0...25, label: {Text("High speed: \(self.rHSC)")})
                                Stepper(value: $rLSC, in: 0...25, label: {Text("Low speed: \(self.rLSC)")})
                            } else {
                                Stepper(value: $rComp, in: 0...25, label: {Text("Rebound: \(self.rComp)")})
                            }
                            
                            // Rebound
//                            Toggle(isOn: $rReboundToggle.animation(), label: {Text("Dual Rebound?")})
                            if rReboundToggle == true {
                                Stepper(value: $rHSR, in: 0...25, label: {Text("High speed: \(self.rHSR)")})
                                Stepper(value: $rLSR, in: 0...25, label: {Text("Low speed: \(self.rLSR)")})
                            } else {
                                Stepper(value: $rReb, in: 0...20, label: {Text("Rebound: \(self.rReb)")})
                            }
                       }
                    }
                    .navigationBarTitle("DialedIn")
                
                
                
                Button(action: {
                    //dismisses the sheet
                     self.presentationMode.wrappedValue.dismiss()
                    
                    let newNote = Notes(context: self.moc)
                    newNote.note = self.note
                    newNote.bike = Bike(context: self.moc)
                    newNote.bike?.name = self.bikeName
                    
                    try? self.moc.save()
                }) {
                    SaveButtonView()
                    }
            }
        }
    }
    
    func getBike() {
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
