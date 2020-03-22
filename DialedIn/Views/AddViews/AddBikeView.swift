//
//  BikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddBikeView: View {
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var bikeName = ""
    @State private var bikeNote = ""
    @State private var setDefault = false
   
    @State private var forkInfo = ""
    @State private var forkDualReboundToggle = false
    @State private var forkDualCompToggle = false
    @State private var lastLowerServiceDate = Date()
    @State private var lastFullForkServiceDate = Date()
    
    @State private var rearSetupIndex = 1
    @State private var rearSetups = ["None", "Air", "Coil"]
    @State private var isCoilToggle = false
    @State private var rearInfo = ""
    @State private var rearDualReboundToggle = false
    @State private var rearDualCompToggle = false
    @State private var lastAirCanServiceDate = Date()
    @State private var lastRearFullServiceDate = Date()
    
//TODO: figure out how to only allow 1 default bike
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Bike Details")){
                        TextField("Bike Name", text: $bikeName)
                        TextField("Note", text: $bikeNote)
                        Toggle(isOn: $setDefault.animation(), label: {Text("Set as Default Bike?")})
                    }
                    
                    Section(header: Text("Fork Details")){
                        TextField("Info", text: $forkInfo)
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
                            TextField("Info", text: $rearInfo)
                            Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?")})

                            Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?")})

                            DatePicker(selection: $lastAirCanServiceDate, in: ...Date(), displayedComponents: .date) {
                            Text("Last Air Can Service")
                            }
                            
                            DatePicker(selection: $lastRearFullServiceDate, in: ...Date(), displayedComponents: .date) {
                            Text("Last Rear Full Service")
                            }
                        } else if rearSetupIndex == 2 {
                            TextField("Info", text: $rearInfo)
                            Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?")})

                            Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?")})

                            DatePicker(selection: $lastRearFullServiceDate, in: ...Date(), displayedComponents: .date) {
                            Text("Last Rear Full Service")
                            }
                        }
                    }
                } .navigationBarTitle("Bike Info", displayMode: .inline)

                Button(action: {
                    //dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()
					self.saveNewBike()
					try? self.moc.save()
                    }) {
                        SaveButtonView()
                        }
                    Spacer()
            }
        }
    }
	
	func saveNewBike() {
		// start at the child and work way up with creating Entities
		let newService = RearService(context: self.moc)
		newService.service = RearShock(context: self.moc)
		let rearShock = newService.service
		newService.service?.bike = Bike(context: self.moc)
		let bike = newService.service?.bike

		bike?.name = self.bikeName
		bike?.bikeNote = self.bikeNote
		bike?.isDefault = self.setDefault

		if self.rearSetupIndex == 1 {
			bike?.hasRearShock = true
			rearShock?.info = self.rearInfo
			rearShock?.dualCompression = self.rearDualCompToggle
			rearShock?.dualRebound = self.rearDualCompToggle
			rearShock?.isCoil = self.isCoilToggle
			newService.airCanService = self.lastAirCanServiceDate
			newService.fullService = self.lastRearFullServiceDate

		} else if self.rearSetupIndex == 2 {
			self.isCoilToggle.toggle()
			
			bike?.hasRearShock = true
			rearShock?.info = self.rearInfo
			rearShock?.dualCompression = self.rearDualCompToggle
			rearShock?.dualRebound = self.rearDualCompToggle
			rearShock?.isCoil = self.isCoilToggle
			newService.airCanService = self.lastAirCanServiceDate
			newService.fullService = self.lastRearFullServiceDate

		} else if self.rearSetupIndex == 0 {
			bike?.hasRearShock = false
			rearShock?.isCoil = false
		}
		
	}
}

struct BikeView_Previews: PreviewProvider {
    static var previews: some View {
        AddBikeView()
    }
}
