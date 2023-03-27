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
        HStack {
            Text("Bike Name:").fontWeight(.thin)
            TextField("Enter Bike Name", text: self.$bikeVM.bikeName ?? "" )
                .onChange(of: bikeVM.bikeName) { newValue in
                    bikeVM.checkBikeNameExists(bikeName: bikeVM.bikeName ?? "")
                    print("DuplicateNameAlert = \(bikeVM.duplicateNameAlert)")
                }
                
            .customTextField()
            .textFieldStyle(PlainTextFieldStyle())
        } //: END HSTACK

        VStack {
            HStack {
                Text("Note:").fontWeight(.thin)
                Spacer()
            }
            TextEditor(text: $bikeVM.bikeNote ?? "")
                .frame(height: 300)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(8)
                .multilineTextAlignment(.leading)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
        } //: END VSTACK
        VStack {
            Toggle(isOn: $bikeVM.isDefault.animation(), label: {Text("Set as Default Bike?")})
            HStack{
                Text("This moves the bike to the top of lists")
                    .font(.caption2)
                    .italic()
                    .foregroundColor(Color.gray)
                    
                Spacer()
            }
        }
    }
}

struct BikeDetailFormView_Previews: PreviewProvider {
    static var previews: some View {
        BikeDetailFormView()
    }
}
