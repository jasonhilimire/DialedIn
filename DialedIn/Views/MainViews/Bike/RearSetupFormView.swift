//
//  RearSetupFormView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/14/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

//TODO: FIX rearSetupIndex not functioning
struct RearSetupFormView: View {
	@ObservedObject var bikeVM = BikeViewModel()
	@ObservedObject var rearShockVM = RearShockViewModel()
	@ObservedObject var rearServiceVM = RearServiceViewModel()
	
	@State private var strokeLength = ""
	@State private var rearTravel = ""
	
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
			Picker("Rear Setup", selection: $bikeVM.rearSetupIndex) {
				ForEach(0..<bikeVM.rearSetups.count) { index in
					Text(self.bikeVM.rearSetups[index]).tag(index)
				}
			}.pickerStyle(SegmentedPickerStyle())
			
			// Display Form based on rear setup from Picker
			if bikeVM.rearSetupIndex == 0 {
				Text("No Rear Suspension").fontWeight(.thin)
				
			} else if bikeVM.rearSetupIndex == 1 {
				HStack {
					Text("Rear Name/Info:").fontWeight(.thin)
					CustomTextField(text: $rearShockVM.info ?? "", placeholder: "Add Rear Info")
				}
				
				HStack {
					Text("Shock Stroke (mm):").fontWeight(.thin)
					CustomNumberField(text: $strokeLength, placeholder: "Used for Sag Calculation")
				}
				
				HStack {
					Text("Rear Travel (mm):").fontWeight(.thin)
					CustomNumberField(text: $rearTravel, placeholder: "Enter Rear Travel in mm")
				}
				
				Toggle(isOn: $rearShockVM.dualRebound.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
				
				Toggle(isOn: $rearShockVM.dualCompression.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
				
				DatePicker(selection: $rearServiceVM.airCanServicedDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Air Can Service").fontWeight(.thin)
				}
				
				DatePicker(selection: $rearServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Rear Full Service").fontWeight(.thin)
				}
			} else if bikeVM.rearSetupIndex == 2 {
				HStack {
					Text("Rear Name/Info:").fontWeight(.thin)
					CustomTextField(text: $rearShockVM.info ?? "", placeholder: "Add Rear Info")
				}
				
				HStack {
					Text("Shock Stroke (mm):").fontWeight(.thin)
					CustomNumberField(text: $strokeLength, placeholder: "Enter Shock Stroke in mm")
					
				}
				
				Toggle(isOn: $rearShockVM.dualCompression.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
				
				Toggle(isOn: $rearShockVM.dualRebound.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
				
				DatePicker(selection: $rearServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Rear Full Service").fontWeight(.thin)
				}
			}
		}
    }
}


