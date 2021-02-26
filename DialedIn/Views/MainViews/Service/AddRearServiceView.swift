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
	@ObservedObject var bikeVM = BikeViewModel()
	@ObservedObject var rearSetupVM = RearShockViewModel()
	
	@State var setupIndex = 1
	
    var body: some View {
		Section(header:
			HStack {
				Image("shock-absorber")
					.resizable()
					.frame(width: 50, height: 50)
					.scaledToFit()
				Text("Rear Service")
			}
		){
			if self.setupIndex == 0 {
				Text("Hardtail").fontWeight(.thin)
			} else if self.setupIndex == 2 {
				Picker("Service Type", selection: $rearService.rearServicedIndex) {
					ForEach(0..<(rearService.rearServiced.count - 1) ) { index in
						Text(self.rearService.rearServiced[index]).tag(index)
					}
				}.pickerStyle(SegmentedPickerStyle())
				
				if rearService.rearServicedIndex == 1 {
					HStack {
						Text("Note:").fontWeight(.thin)
						
						CustomTextField(text: $rearService.serviceNote, placeholder: "")
					}
					DatePicker(selection: $rearService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
						Text("Date Serviced").fontWeight(.thin)
					}
					
				}
			} else {
				Picker("Service Type", selection: $rearService.rearServicedIndex) {
					ForEach(0..<rearService.rearServiced.count) { index in
						Text(self.rearService.rearServiced[index]).tag(index)
					}
				}.pickerStyle(SegmentedPickerStyle())
				
				if rearService.rearServicedIndex == 1 {
					Text("Full Service Includes Air Can Service").fontWeight(.thin).italic()
					HStack {
						Text("Note:").fontWeight(.thin)
						CustomTextField(text: $rearService.serviceNote, placeholder: "")
					}
					DatePicker(selection: $rearService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
						Text("Date Serviced").fontWeight(.thin)
					}
					
				} else if rearService.rearServicedIndex == 2 {
					Text("Air Can only Serviced").fontWeight(.thin).italic()
					HStack {
						Text("Note:").fontWeight(.thin)
						CustomTextField(text: $rearService.serviceNote, placeholder: "")
					}
					DatePicker(selection: $rearService.airCanServicedDate, in: ...Date(), displayedComponents: .date) {
						Text("Date Serviced").fontWeight(.thin)
					}
				}
			}
		}.onAppear(perform: {self.setup()})
    }
	
	func setup(){
//TODO- this isnt working at all if coming from HomePage appears the VM isnt getting updated properly
		if bikeVM.hasRearShock == false {
			setupIndex = 0
		} else if rearSetupVM.isCoil == true  {
			setupIndex = 2
		} else {
			setupIndex = 1
		}

	}
}

struct AddRearServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddRearServiceView()
    }
}
