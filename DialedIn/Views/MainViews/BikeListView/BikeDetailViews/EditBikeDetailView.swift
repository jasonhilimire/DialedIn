//
//  EditBikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 6/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct EditBikeDetailView: View {

	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var keyboard = KeyboardObserver()
	@ObservedObject var front = NoteFrontSetupModel()
	@ObservedObject var rear = NoteRearSetupModel()
	
	@State private var bikeName = ""
	@State private var bikeNote = ""
	@State private var setDefault = false
	
	@State private var forkInfo = ""
	@State private var forkDualReboundToggle = false
	@State private var forkDualCompToggle = false
	@State private var forkTravel = ""
	
	@State private var rearSetupIndex = 0
	@State private var rearSetups = ["None", "Air", "Coil"]
	@State private var isCoilToggle = false
	@State private var rearInfo = ""
	@State private var rearDualReboundToggle = false
	@State private var rearDualCompToggle = false
	@State private var strokeLength = ""
	
	@State private var slideScreen = false
	
	let bike: Bike
	
	//TODO: figure out how to only allow 1 default bike
	var body: some View {
		NavigationView {
			VStack {
				Form {
					Section(header: Text("Bike Details")){
						HStack {
							Text("Bike Name: \(self.bike.wrappedBikeName)").fontWeight(.thin)
							TextView(text: $bikeName).cornerRadius(8)
							
						}
						HStack {
							Text("Note:").fontWeight(.thin)
							TextView(text: $bikeNote).cornerRadius(8)
							
						}
						//                        Toggle(isOn: $setDefault.animation(), label: {Text("Set as Default Bike?")})
					}
					.onTapGesture {
						self.slideScreen = false
					}
					
					Section(header: Text("Fork Details")){
						HStack{
							Text("Fork Info:").fontWeight(.thin)
							TextView(text: $forkInfo).cornerRadius(8)
								.onTapGesture {
									self.slideScreen = false
							}
						}
						
						HStack {
							Text("Travel (mm):").fontWeight(.thin)
							CustomUIKitTextField(text: $forkTravel, placeholder: "Enter Fork length in mm")
						}
						
						Toggle(isOn: $forkDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
						Toggle(isOn: $forkDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
						
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
									.onTapGesture {
										self.slideScreen = true
								}
							}
							
							HStack {
								Text("Travel (mm):").fontWeight(.thin)
								CustomUIKitTextField(text: $strokeLength, placeholder: "Enter Shock Stroke in mm")
							}
							
							
							Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
							
							Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
							
						} else if rearSetupIndex == 2 {
							HStack {
								Text("Rear Info:").fontWeight(.thin)
								TextView(text: $rearInfo).cornerRadius(8)
									.onTapGesture {
										self.slideScreen = true
								}
							}
							
							HStack {
								Text("Travel (mm):").fontWeight(.thin)
								CustomUIKitTextField(text: $strokeLength, placeholder: "Enter Shock Stroke in mm")
									.onTapGesture {
										self.slideScreen = true
								}
							}
							
							Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
							
							Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
							
						}
					}
					
				} .navigationBarTitle("Edit Bike Info", displayMode: .inline)
					
					.offset(y: slideScreen ?  -keyboard.height  :  0)
					.animation(.spring())
				
				
				Button(action: {
					//dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()
					self.saveNewBike()
					print("Dual Comp: \(self.$forkDualCompToggle)")
					print("Dual Reb: \(self.$forkDualReboundToggle)")
					try? self.moc.save()
				}) {
					SaveButtonView()
				}.buttonStyle(OrangeButtonStyle())
				Spacer()
			}
			.animation(.default)
		}
			// Dismisses the keyboard
			.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
			.onAppear(perform: {self.setup()})
	}
	
	func saveNewBike() {
		// - Bike Edit
		
		bike.name = self.bikeName
		bike.bikeNote = self.bikeNote
		bike.isDefault = self.setDefault
		
		// - Front Creation
		bike.frontSetup?.travel = Double(self.forkTravel) ?? 0.0
		bike.frontSetup?.dualCompression = self.forkDualCompToggle
		bike.frontSetup?.dualRebound = self.forkDualReboundToggle
		bike.frontSetup?.info = self.forkInfo

		
		
		// - Rear Creation -
		
		
		if self.rearSetupIndex == 1 {
			bike.hasRearShock = true
			bike.rearSetup?.info = self.rearInfo
			bike.rearSetup?.strokeLength = Double(self.strokeLength) ?? 0.0
			bike.rearSetup?.dualCompression = self.rearDualCompToggle
			bike.rearSetup?.dualRebound = self.rearDualCompToggle
			bike.rearSetup?.isCoil = self.isCoilToggle

			
		} else if self.rearSetupIndex == 2 {
			self.isCoilToggle.toggle()
			
			bike.hasRearShock = true
			bike.rearSetup?.info = self.rearInfo
			bike.rearSetup?.strokeLength = Double(self.strokeLength) ?? 0.0
			bike.rearSetup?.dualCompression = self.rearDualCompToggle
			bike.rearSetup?.dualRebound = self.rearDualCompToggle
			bike.rearSetup?.isCoil = self.isCoilToggle

			
		} else if self.rearSetupIndex == 0 {
			bike.hasRearShock = false
			bike.rearSetup?.isCoil = false
		}
	}
	
	func setup(){
		//TODO: Notes & info are working but not travel and toggles
		bikeName = self.bike.wrappedBikeName
		bikeNote = self.bike.bikeNote ?? ""
		
		forkInfo = bike.frontSetup?.self.wrappedForkInfo ?? ""
		forkDualReboundToggle = self.front.fReb
		forkDualCompToggle = self.front.fComp
		forkTravel = "\(front.fTravel)"
		
		rearInfo = bike.rearSetup?.wrappedRearInfo ?? ""
		rearDualReboundToggle = self.rear.rReb
		rearDualCompToggle = self.rear.rComp
		strokeLength = "\(self.rear.travel)"
		
		setIndex()
		print("Index is \(self.rearSetupIndex)")
		
	}
	
	func setIndex(){
		let hasRear = self.bike.hasRearShock
		let isCoil = self.bike.rearSetup?.isCoil
		
		print("Coil: \(isCoil)")
		print("HT: \(hasRear)")
		if hasRear == false {
			rearSetupIndex = 0
		} else if isCoil == true {
			rearSetupIndex = 2
		} else {
			rearSetupIndex = 1
		}
	}
}
