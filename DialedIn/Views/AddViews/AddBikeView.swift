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
	
	@ObservedObject var keyboard = KeyboardObserver()
    
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
						HStack {
							Text("Bike Name:").fontWeight(.thin)
							TextView(text: $bikeName).cornerRadius(8)
						}
						HStack {
							Text("Note:").fontWeight(.thin)
							TextView(text: $bikeNote).cornerRadius(8)
						}
//                        Toggle(isOn: $setDefault.animation(), label: {Text("Set as Default Bike?")})
                    }
                    
                    Section(header: Text("Fork Details")){
						HStack{
							Text("Fork Info:").fontWeight(.thin)
							TextView(text: $forkInfo).cornerRadius(8)
						}
                        Toggle(isOn: $forkDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
                        Toggle(isOn: $forkDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
                        
                        DatePicker(selection: $lastLowerServiceDate, in: ...Date(), displayedComponents: .date) {
                        Text("Last Lower Service").fontWeight(.thin)
                        }
                        
                        DatePicker(selection: $lastFullForkServiceDate, in: ...Date(), displayedComponents: .date) {
                        Text("Last Full Service").fontWeight(.thin)
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
                            Text("No Rear Suspension").fontWeight(.thin)
                            
                        } else if rearSetupIndex == 1 {
							HStack {
								Text("Rear Info:").fontWeight(.thin)
								TextView(text: $rearInfo).cornerRadius(8)
							}
							
                            Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})

                            Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})

                            DatePicker(selection: $lastAirCanServiceDate, in: ...Date(), displayedComponents: .date) {
								Text("Last Air Can Service").fontWeight(.thin)
                            }
                            
                            DatePicker(selection: $lastRearFullServiceDate, in: ...Date(), displayedComponents: .date) {
                            Text("Last Rear Full Service").fontWeight(.thin)
                            }
                        } else if rearSetupIndex == 2 {
							HStack {
								Text("Rear Info:").fontWeight(.thin)
								TextView(text: $rearInfo).cornerRadius(8)
							}
                            Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})

                            Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})

                            DatePicker(selection: $lastRearFullServiceDate, in: ...Date(), displayedComponents: .date) {
                            Text("Last Rear Full Service").fontWeight(.thin)
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
                        }.buttonStyle(OrangeButtonStyle())
                    Spacer()
            }
        }
			// Dismisses the keyboard
			.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
    }
	
	func saveNewBike() {
		// start at the child and work way up with creating Entities
		/// Setup
		let newRearService = RearService(context: self.moc)
		newRearService.service = RearShock(context: self.moc)
		let newRearShock = newRearService.service
		newRearService.service?.bike = Bike(context: self.moc)
		let newFrontService = FrontService(context: self.moc)
		newFrontService.service = Fork(context: self.moc)
		let newFork = newFrontService.service
		let newBike = newRearService.service?.bike
		
		let dateString = dateFormatter.string(from: Date())
		
		
		// - Bike Creation
		
		newBike?.name = self.bikeName
		newBike?.bikeNote = self.bikeNote
		newBike?.isDefault = self.setDefault
		
		// - Front Creation
		newFrontService.service?.bike = newBike
		newFork?.dualCompression = self.forkDualCompToggle
		newFork?.dualRebound = self.forkDualReboundToggle
		newFork?.info = self.forkInfo
		newFrontService.lowersService = self.lastLowerServiceDate
		newFrontService.fullService = self.lastFullForkServiceDate
		newFrontService.serviceNote = "Bike Created: \(dateString), no services done yet"
		

		// - Rear Creation -
		
		
		if self.rearSetupIndex == 1 {
			newBike?.hasRearShock = true
			newRearShock?.info = self.rearInfo
			newRearShock?.dualCompression = self.rearDualCompToggle
			newRearShock?.dualRebound = self.rearDualCompToggle
			newRearShock?.isCoil = self.isCoilToggle
			newRearService.airCanService = self.lastAirCanServiceDate
			newRearService.fullService = self.lastRearFullServiceDate
			
			newRearService.serviceNote = "Bike Created: \(dateString), no services done yet"

		} else if self.rearSetupIndex == 2 {
			self.isCoilToggle.toggle()
			
			newBike?.hasRearShock = true
			newRearShock?.info = self.rearInfo
			newRearShock?.dualCompression = self.rearDualCompToggle
			newRearShock?.dualRebound = self.rearDualCompToggle
			newRearShock?.isCoil = self.isCoilToggle
			newRearService.airCanService = self.lastAirCanServiceDate
			newRearService.fullService = self.lastRearFullServiceDate
			newRearService.serviceNote = "Bike Created: \(dateString), no services done yet"

		} else if self.rearSetupIndex == 0 {
			newBike?.hasRearShock = false
			newRearShock?.isCoil = false
		}
	}
}

struct BikeView_Previews: PreviewProvider {
    static var previews: some View {
        AddBikeView()
    }
}
