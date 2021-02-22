//
//  RearSetupFormView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/14/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

//TODO: FIX rearSetupIndex not functioning until click in a field
struct RearSetupFormView: View {
	@ObservedObject var bikeVM = BikeViewModel()
	@ObservedObject var rearShockVM = RearShockViewModel()
	@ObservedObject var rearServiceVM = RearServiceViewModel()
	
	@Binding var rearSetupIndex: Int
	@State var rearSetups = ["None", "Air", "Coil"]
	
	@Binding var isAdd: Bool

    var body: some View {
		Section(header:
					HStack {
						Image("shock-absorber")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Shock Details")
					}
		){
			Picker("Rear Setup", selection: $rearSetupIndex) {
				ForEach(0..<bikeVM.rearSetups.count) { index in
					Text(self.bikeVM.rearSetups[index]).tag(index)
				}
			}.pickerStyle(SegmentedPickerStyle())


			
// TODO: how to pass setup index to ViewModel ?? If using from ViewModel- on edit setup its correct, but changing has no effect same with ADD

			// Display Form based on rear setup from Picker

			if rearSetupIndex == 0 {
				Text("No Rear Suspension").fontWeight(.thin)
				
			} else if rearSetupIndex == 1 { //AIR SHOCK
				HStack {
					Text("Rear Name/Info:").fontWeight(.thin)
					CustomTextField(text: $rearShockVM.info ?? "", placeholder: "Add Rear Info")
				}
				
				HStack {
					Text("Shock Stroke (mm):").fontWeight(.thin)
					CustomNumberField(text: $rearShockVM.strokeLengthString ?? "0.0", placeholder: "Used for Sag Calculation")
				}
				
				HStack {
					Text("Rear Travel (mm):").fontWeight(.thin)
					CustomNumberField(text: $rearShockVM.travelString ?? "0.0", placeholder: "Enter Rear Travel in mm")
				}
				
				Toggle(isOn: $rearShockVM.dualRebound.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
				
				Toggle(isOn: $rearShockVM.dualCompression.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
				
				if isAdd == true {
					DatePicker(selection: $rearServiceVM.airCanServicedDate, in: ...Date(), displayedComponents: .date) {
						Text("Last Air Can Service").fontWeight(.thin)
					}
					
					DatePicker(selection: $rearServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
						Text("Last Rear Full Service").fontWeight(.thin)
					}
				}
			} else if rearSetupIndex == 2 { // COIL SHOCK
				HStack {
					Text("Rear Name/Info:").fontWeight(.thin)
					CustomTextField(text: $rearShockVM.info ?? "", placeholder: "Add Rear Info")
				}
				
				HStack {
					Text("Shock Stroke (mm):").fontWeight(.thin)
					CustomNumberField(text: $rearShockVM.strokeLengthString ?? "0.0", placeholder: "Used for Sag Calculation")
				}
				
				HStack {
					Text("Rear Travel (mm):").fontWeight(.thin)
					CustomNumberField(text: $rearShockVM.travelString ?? "0.0", placeholder: "Enter Rear Travel in mm")
				}
				
				Toggle(isOn: $rearShockVM.dualCompression.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
				
				Toggle(isOn: $rearShockVM.dualRebound.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
				
				if isAdd == true {
					DatePicker(selection: $rearServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
						Text("Last Rear Full Service").fontWeight(.thin)
					}
				}
			}
		}
		.onDisappear(perform: {
			rearIndexChange()
		})
	}
	
	func rearIndexChange(){
		bikeVM.rearSetupIndex = rearSetupIndex
	}
	

}


