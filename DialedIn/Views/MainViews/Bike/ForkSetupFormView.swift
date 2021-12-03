//
//  ForkSetupFormView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/14/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ForkSetupFormView: View {
	@ObservedObject var forkVM = ForkViewModel()
	@ObservedObject var frontServiceVM = FrontServiceViewModel()

	@Binding var isAdd: Bool
	@State var service1text = "Lowers"
	@State var service2text = "Full"
	@State var setupIndex = 0
	
    var body: some View {
		Section(header:
					HStack {
						Image("bicycle-fork")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Fork Details")
					}
				
		){
			HStack{
				Text("Fork Name/Info:").fontWeight(.thin)
				TextField("Add Fork Info", text: $forkVM.info ?? "")
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())

			}
			
			HStack {
				Text("Travel (mm):").fontWeight(.thin)
				TextField("Enter Fork length in mm", text: $forkVM.travelString ?? "0.0")
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())
					.keyboardType(.decimalPad)
			}
			
			Toggle(isOn: $forkVM.dualRebound.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
			Toggle(isOn: $forkVM.dualCompression.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
			if isAdd == true { //Show Service dates if isAdd == True
				DatePicker(selection: $frontServiceVM.lowersServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Lower Service").fontWeight(.thin)
				}
				
				DatePicker(selection: $frontServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Full Service").fontWeight(.thin)
				}
			}
			
			ServiceWarningView(service1: $forkVM.lowersServiceSettingDays, service2: $forkVM.fullServiceSettingDays, service1text: service1text, service2text: service2text, setupIndex: setupIndex)
		}
		
		
    }

}

