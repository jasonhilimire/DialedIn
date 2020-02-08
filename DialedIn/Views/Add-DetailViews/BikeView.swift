//
//  BikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeView: View {
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    

    @State private var bikeName = ""
    @State private var bikeNote = ""
   
    @State private var forkDualReboundToggle = false
    @State private var forkDualCompToggle = false
    @State private var lastLowerServiceDate = Date()
    @State private var lastFullForkServiceDate = Date()
    
    @State private var rearSetupIndex = 1
    @State private var rearSetups = ["None", "Air", "Coil"]
    
    @State private var isCoilToggle = false
    @State private var rearDualReboundToggle = false
    @State private var rearDualCompToggle = false
    @State private var lastAirCanServiceDate = Date()
    @State private var lastRearFullServiceDate = Date()
    
    
    var body: some View {
        
        VStack {
            Spacer()
            GrabBarView()
            Text("Bike Info")
                .font(.title)
                .fontWeight(.thin)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .padding(.top)
            Form {
                
                Section(header: Text("Bike Details")){
                    TextField("Bike Name", text: $bikeName )
                    TextField("Note", text: $bikeNote)
                }
                Section(header: Text("Fork Details")){
                    Toggle(isOn: $forkDualReboundToggle.animation(), label: {Text("Dual Rebound?")})
                    Toggle(isOn: $forkDualCompToggle.animation(), label: {Text("Dual Compression?")})
                    
                    DatePicker(selection: $lastLowerServiceDate, in: ...Date(), displayedComponents: .date) {
                    Text("Last Lower Service")
                    }
                    
                    DatePicker(selection: $lastFullForkServiceDate, in: ...Date(), displayedComponents: .date) {
                    Text("Last Full Service ")
                    }
                }
                
                Section(header: Text("Shock Details")){
                    Picker("Rear Setup", selection: $rearSetupIndex) {
                        ForEach(0..<rearSetups.count) { index in
                            Text(self.rearSetups[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    // Display Form based on rear setup from Picker
                    if rearSetupIndex == 0 {
                        Text("No Rear Suspension")
                        
                    } else if rearSetupIndex == 1 {
                        
                        Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?")})

                        Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?")})

                        DatePicker(selection: $lastAirCanServiceDate, in: ...Date(), displayedComponents: .date) {
                        Text("Last Air Can Service")
                        }
                        
                        DatePicker(selection: $lastRearFullServiceDate, in: ...Date(), displayedComponents: .date) {
                        Text("Last Rear Full Service")
                        }
                    } else if rearSetupIndex == 2 {
                        Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?")})

                        Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?")})

                        DatePicker(selection: $lastRearFullServiceDate, in: ...Date(), displayedComponents: .date) {
                        Text("Last Rear Full Service")
                        }
                    }
                }
            }

            Button(action: {
                //dismisses the sheet
                 self.presentationMode.wrappedValue.dismiss()
                 
                let newBike = Bike(context: self.moc)
                newBike.name = self.bikeName
                newBike.bikeNote = self.bikeNote
                
                newBike.frontSetup?.dualCompression = self.forkDualCompToggle
                newBike.frontSetup?.dualRebound = self.forkDualCompToggle
                newBike.frontSetup?.lowerLastServiced = self.lastLowerServiceDate
                newBike.frontSetup?.lasfFullService = self.lastFullForkServiceDate
                
                if self.rearSetupIndex == 1 {
                    newBike.rearSetup?.dualCompression = self.rearDualCompToggle
                    newBike.rearSetup?.dualRebound = self.rearDualReboundToggle
                    newBike.rearSetup?.isCoil = self.isCoilToggle
                    newBike.rearSetup?.lastAirCanService = self.lastAirCanServiceDate
                    newBike.rearSetup?.lastFullService = self.lastRearFullServiceDate
                } else if self.rearSetupIndex == 2 {
                    self.isCoilToggle.toggle()
                    newBike.rearSetup?.dualCompression = self.rearDualCompToggle
                    newBike.rearSetup?.dualRebound = self.rearDualReboundToggle
                    newBike.rearSetup?.isCoil = self.isCoilToggle
                    newBike.rearSetup?.lastAirCanService = self.lastAirCanServiceDate
                    newBike.rearSetup?.lastFullService = self.lastRearFullServiceDate
                }
                
                 try? self.moc.save()
                }) {
                    SaveButtonView()
                    }
                Spacer()
        }
    }
    
    
}

struct BikeView_Previews: PreviewProvider {
    static var previews: some View {
        BikeView()
    }
}
