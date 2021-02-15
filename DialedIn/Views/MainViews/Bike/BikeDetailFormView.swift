//
//  BikeDetailFormView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/14/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

//TODO: fix why the CustomTextField doesnt work here? but works fine in fork & rear setup

struct BikeDetailFormView: View {
	@ObservedObject var bikeVM = BikeViewModel()
	
    var body: some View {
		Section(header: Text("Bike Details")){
			HStack {
				Text("Bike Name:").fontWeight(.thin)
				CustomTextField(text: $bikeVM.bikeName ?? "", placeholder: "Enter a Name")
			}
			HStack {
				Text("Note:").fontWeight(.thin)
				CustomTextField(text: $bikeVM.bikeNote ?? "", placeholder: "Add a Note")
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
