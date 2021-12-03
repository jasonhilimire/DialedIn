//
//  ServiceWarningView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 12/2/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ServiceWarningView: View {
	@Binding var service1: Int
	@Binding var service2: Int
	@State var service1text: String
	@State var service2text: String
	
	
	
    var body: some View {
		// Ads a section with service warning in Days for 2 types of service, not baked in yet
		Section(header: Text("Service Warning: In Days").fontWeight(.thin)){
			HStack {
				Text(service1text).fontWeight(.thin)
				TextField("Days", value: $service1, formatter: NumberFormatter())
				//					TextField("Days", text: Binding( // get the Binding value as a string and convert to an Integer
				//						get: { String(frontServiceVM.elapsedLowersServiceDays) },
				//						set: { frontServiceVM.elapsedLowersServiceDays = Int($0) ?? 90 }
				//					))
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())
					.keyboardType(.decimalPad)
				Text(service2text).fontWeight(.thin)
				TextField("Days", value: $service2, formatter: NumberFormatter())
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())
					.keyboardType(.decimalPad)
			}
		}
    }
}

