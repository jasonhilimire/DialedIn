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
			if isAdd == true {
				DatePicker(selection: $frontServiceVM.lowersServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Lower Service").fontWeight(.thin)
				}
				
				DatePicker(selection: $frontServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
					Text("Last Full Service").fontWeight(.thin)
				}
			}
		}
// Ads a section with service warning in Days for Fork, not fully baked yet, saving not enabled
		Section(header: Text("Service Warning: In Days").fontWeight(.thin)){
			HStack {
				Text("Lowers").fontWeight(.thin)
				TextField("Days", value: $frontServiceVM.elapsedLowersServiceDays, formatter: NumberFormatter())
				//					TextField("Days", text: Binding( // get the Binding value as a string and convert to an Integer
				//						get: { String(frontServiceVM.elapsedLowersServiceDays) },
				//						set: { frontServiceVM.elapsedLowersServiceDays = Int($0) ?? 90 }
				//					))
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())
					.keyboardType(.decimalPad)
				Text("Full").fontWeight(.thin)
				TextField("Days", value: $frontServiceVM.elapsedFullServiceDays, formatter: NumberFormatter())
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())
					.keyboardType(.decimalPad)
			}
		}
    }

}

