//
//  SaveButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/30/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

// TODO: Change this to a buttonstyle
struct SaveButtonView: View {
	@Binding var buttonText: String
   
	
	var body: some View {
         HStack {
               Image(systemName: "checkmark.circle")
               Text("\(buttonText)")
				.fontWeight(.regular)
			}
			
    }
}

//struct SaveButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//		SaveButtonView(saveText: "Save")
//    }
//}

struct OrangeButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.multilineTextAlignment(.center)
			.foregroundColor(Color("TextColor"))
			.padding().frame(maxWidth: 400)
			.background(Color.orange)
			.cornerRadius(15)
			.scaleEffect(configuration.isPressed ? 0.6 : 1.0)
			.animation(.spring())
	}
}