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
				CustomTextField(text: $forkVM.info ?? "", placeholder: "Add Fork Info")
			}
			
			HStack {
				Text("Travel (mm):").fontWeight(.thin)
				CustomNumberField(text: $forkVM.travelString ?? "0.0", placeholder: "Enter Fork length in mm")
			}
			
			Toggle(isOn: $forkVM.dualRebound.animation(), label: {Text("Dual Rebound?").fontWeight(.thin)})
			Toggle(isOn: $forkVM.dualCompression.animation(), label: {Text("Dual Compression?").fontWeight(.thin)})
// TODO: Wrap in an isAdd if Statement
			DatePicker(selection: $frontServiceVM.lowersServiceDate, in: ...Date(), displayedComponents: .date) {
				Text("Last Lower Service").fontWeight(.thin)
			}
			
			DatePicker(selection: $frontServiceVM.fullServiceDate, in: ...Date(), displayedComponents: .date) {
				Text("Last Full Service").fontWeight(.thin)
			}
		}
    }

}

