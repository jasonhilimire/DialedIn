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
    
    
    @State private var hasRearToggle = true
    @State private var isCoilToggle = false
    @State private var rearDualReboundToggle = false
    @State private var rearDualCompToggle = false
    @State private var lastAirCanServiceDate = Date()
    @State private var lastRearFullServiceDate = Date()
    
    
    var body: some View {
        
        VStack {
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
                    
                    DatePicker(selection: $lastLowerServiceDate, in: ...Date(), displayedComponents: .date) {
                    Text("Last Full Service ")
                    }
                }
                Section(header: Text("Shock Details")){
                    Toggle(isOn: $hasRearToggle.animation(), label: {Text("Rear Shock?")})
                    
                    if hasRearToggle == true {
                        Toggle(isOn: $isCoilToggle.animation(), label: {Text("Coil?")})

                        Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?")})
                        
                        Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?")})
                        
                        if isCoilToggle == false {
                            DatePicker(selection: $lastAirCanServiceDate, in: ...Date(), displayedComponents: .date) {
                            Text("Last Air Can Service")
                            }
                        }
                        
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
                
                 try? self.moc.save()
                }) {
                    SaveButtonView()
                    }
            
        }

    }
}

struct BikeView_Previews: PreviewProvider {
    static var previews: some View {
        BikeView()
    }
}
