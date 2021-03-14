//
//  AddRearServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddRearServiceView: View {
	
	@ObservedObject var rearService = RearServiceViewModel()
	
	let bike: Bike
	
    var body: some View {
		Section(header:
			HStack {
				Image("shock-absorber")
					.resizable()
					.frame(width: 50, height: 50)
					.scaledToFit()
				Text("Rear Service")
			}
		){ // SETUP FOR REAR YYPES

			if bike.hasRearShock == false {
				Text("Hardtail").fontWeight(.thin)
			} else if bike.rearSetup?.isCoil == true { //: COIL
				Picker("Service Type", selection: $rearService.rearServicedIndex) {
					ForEach(0..<(rearService.rearServiced.count - 1) ) { index in
						Text(self.rearService.rearServiced[index]).tag(index)
					}
				}.pickerStyle(SegmentedPickerStyle())
			
			//: Coil only has 0/1 selection
				if rearService.rearServicedIndex == 1 { //: AIRCAN
					HStack {
						Text("Note:").fontWeight(.thin)
						TextField("", text: $rearService.serviceNote)
							.customTextField()
							.textFieldStyle(PlainTextFieldStyle())
					}
					DatePicker(selection: $rearService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
						Text("Date Serviced").fontWeight(.thin)
					}
					
				}
			} else { //: AIR
				Picker("Service Type", selection: $rearService.rearServicedIndex) {
					ForEach(0..<rearService.rearServiced.count) { index in
						Text(self.rearService.rearServiced[index]).tag(index)
					}
				}.pickerStyle(SegmentedPickerStyle())
				
		// SHOW ITEMS BASED ON PICKER SELECTION FOR AIR & FULL SERVICE
				if rearService.rearServicedIndex == 1 {
					Text("Full Service Includes Air Can Service").fontWeight(.thin).italic()
					HStack {
						Text("Note:").fontWeight(.thin)
						TextField("", text: $rearService.serviceNote)
							.customTextField()
							.textFieldStyle(PlainTextFieldStyle())
					}
					DatePicker(selection: $rearService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
						Text("Date Serviced").fontWeight(.thin)
					}
					
				} else if rearService.rearServicedIndex == 2 {
					Text("Air Can only Serviced").fontWeight(.thin).italic()
					HStack {
						Text("Note:").fontWeight(.thin)
						TextField("", text: $rearService.serviceNote)
							.customTextField()
							.textFieldStyle(PlainTextFieldStyle())
					}
					DatePicker(selection: $rearService.airCanServicedDate, in: ...Date(), displayedComponents: .date) {
						Text("Date Serviced").fontWeight(.thin)
					}
				}
			}
		}
    }
	

}

//struct AddRearServiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRearServiceView()
//    }
//}

