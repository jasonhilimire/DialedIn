//
//  BikeDetailFormView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/14/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI


struct BikeDetailFormView: View {
	@ObservedObject var bikeVM = BikeViewModel()
	
    var body: some View {
		Section(header: Text("Bike Details")){
			HStack {
				Text("Bike Name:").fontWeight(.thin)
				TextField("Enter Bike Name", text: self.$bikeVM.bikeName ?? "" , onEditingChanged: { (changed) in
					if changed {
						print("text edit has begun")
//						bikeVM.checkBikeNameExists(bikeName: bikeVM.bikeName ?? "")
//						print("duplicateNameAlert = \(bikeVM.duplicateNameAlert)")
					} else {
						print("committed the change")
					}
					
				}).customTextField()
				.textFieldStyle(PlainTextFieldStyle())
			}
			
			HStack {
				Text("Note:").fontWeight(.thin)
				TextField("Enter a Note", text: $bikeVM.bikeNote ?? "")
					.customTextField()
					.textFieldStyle(PlainTextFieldStyle())

			}
//                        Toggle(isOn: $bikeVM.isDefault.animation(), label: {Text("Set as Default Bike?")})
		}
    }
}

struct BikeDetailFormView_Previews: PreviewProvider {
    static var previews: some View {
        BikeDetailFormView()
    }
}
