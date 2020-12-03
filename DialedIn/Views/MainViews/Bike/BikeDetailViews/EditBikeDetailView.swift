//
//  EditBikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 6/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct EditBikeDetailView: View {
	//MARK: - PROPERTIES -

	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@EnvironmentObject var showScreenBool: BoolModel
	
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
	
	@State private var saveText = "Save"
	
//	let bike: Bike
	
	//TODO: figure out how to only allow 1 default bike
	//MARK: - BODY -
	var body: some View {
//		NavigationView {
			VStack {
				Form {
					Section(header: Text("Bike Details")){
						HStack {
							Text("Bike Name: ").fontWeight(.thin)
							CustomTextField(text: $bikeName, placeholder: "Enter a name")
						}
						
						HStack {
							Text("Note:").fontWeight(.thin)
							CustomTextField(text: $bikeNote, placeholder: "Add a note")
						}
						//                        Toggle(isOn: $setDefault.animation(), label: {Text("Set as Default Bike?")})
					}
					
					
					Section(header: Text("Fork Details")){
						HStack{
							Text("Fork Name/Info:").fontWeight(.thin)
							CustomTextField(text: $forkInfo, placeholder: "Fork Description")
						}
						
						HStack {
							Text("Travel (mm):").fontWeight(.thin)
							CustomNumberField(text: $forkTravel, placeholder: "Enter Fork length in mm")
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
								Text("Rear Name/Info:").fontWeight(.thin)
								CustomTextField(text: $rearInfo, placeholder: "Rear Description")
							}
							
							HStack {
								Text("Stroke Travel (mm):").fontWeight(.thin)
								CustomNumberField(text: $strokeLength, placeholder: "Enter Shock Stroke in mm")
							}
							
							Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
							
							Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
							
						} else if rearSetupIndex == 2 {
							HStack {
								Text("Rear Name/Info:").fontWeight(.thin)
								CustomTextField(text: $rearInfo, placeholder: "Rear Description")
							}
							
							HStack {
								Text("Stroke Travel (mm):").fontWeight(.thin)
								CustomNumberField(text: $strokeLength, placeholder: "Enter Shock Stroke in mm")
							}
							
							Toggle(isOn: $rearDualReboundToggle.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
							
							Toggle(isOn: $rearDualCompToggle.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
						}
					}
					
				Button(action: {
					//dismisses the sheet
					self.updateBike()

					withAnimation(.linear(duration: 0.05), {
						self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
					})
					
					try? self.moc.save()
					hapticSuccess()
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						self.presentationMode.wrappedValue.dismiss()
					}
				}) {
					SaveButtonView(buttonText: $saveText)
				}.buttonStyle(OrangeButtonStyle())
				Spacer()
			}
			.animation(.default)
		}
			// Dismisses the keyboard
			.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
			.onAppear(perform: {self.setup()})
	}
	
	//MARK: - FUNCTIONS -
	
	func updateBike() {
		// - Bike Edit
		
		let bike = fetchBike(for: showScreenBool.bikeName)
		
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
//		bikeName = self.bike.wrappedBikeName
		bikeName = showScreenBool.bikeName
		let bike = fetchBike(for: bikeName)
		bikeNote = bike.bikeNote ?? ""
		
		forkInfo = bike.frontSetup?.self.wrappedForkInfo ?? ""
		forkTravel = "\(bike.frontSetup?.travel ?? 0)"
		
		rearInfo = bike.rearSetup?.wrappedRearInfo ?? ""
		strokeLength = "\(bike.rearSetup?.strokeLength ?? 0)" 
	
		setToggles()
		setIndex()
	}
	
	func setIndex(){
		let bike = fetchBike(for: bikeName)
		
		let hasRear = bike.hasRearShock
		let isCoil = bike.rearSetup?.isCoil

		if hasRear == false {
			rearSetupIndex = 0
		} else if isCoil == true {
			rearSetupIndex = 2
		} else {
			rearSetupIndex = 1
		}
	}
	
	func setToggles() {
		let bike = fetchBike(for: bikeName)
		
		forkDualReboundToggle = bike.frontSetup!.dualRebound ? true : false
		forkDualCompToggle = bike.frontSetup!.dualCompression ? true : false
		rearDualReboundToggle = bike.rearSetup!.dualRebound ? true : false
		rearDualCompToggle = bike.rearSetup!.dualCompression ? true: false
	
	}
}
