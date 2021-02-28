//
//  AddFrontServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddFrontServiceView: View {
	
	@ObservedObject var frontService = FrontServiceViewModel()
	
    var body: some View {
		Section(header:
					HStack {
						Image("bicycle-fork")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Front Service")
					}
		){
			
			Picker("Service Type", selection: $frontService.frontServicedIndex) {
				ForEach(0..<frontService.frontServiced.count) { index in
					Text(self.frontService.frontServiced[index]).tag(index)
				}
			}.pickerStyle(SegmentedPickerStyle())
			if frontService.frontServicedIndex == 1 {
				Text("Full Service Includes Lowers Service").fontWeight(.thin).italic()
				HStack {
					Text("Note:").fontWeight(.thin)
					TextField("", text: $frontService.serviceNote)
						.font(Font.body.weight(.thin))
						.textFieldStyle(PlainTextFieldStyle())
				}
				
				DatePicker(selection: $frontService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Date Serviced").fontWeight(.thin)
				}
				
			} else if frontService.frontServicedIndex == 2 {
				Text("Lowers only Serviced").fontWeight(.thin).italic()
				HStack {
					Text("Note:").fontWeight(.thin)
					TextField("", text: $frontService.serviceNote)
						.font(Font.body.weight(.thin))
						.textFieldStyle(PlainTextFieldStyle())
				}
				DatePicker(selection: $frontService.lowersServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Date Serviced").fontWeight(.thin)
				}
				
			}
		}
    }
}

struct AddFrontServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddFrontServiceView()
    }
}
