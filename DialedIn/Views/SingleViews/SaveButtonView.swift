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
    var body: some View {
         HStack {
               Image(systemName: "checkmark.circle")
               Text("Save")
				.fontWeight(.thin)
			}

    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView()
    }
}

struct OrangeButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.multilineTextAlignment(.center)
			.foregroundColor(Color("TextColor"))
			.padding().frame(maxWidth: 400)
			.background(Color.orange)
//			.background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
			.cornerRadius(8)
			.scaleEffect(configuration.isPressed ? 0.9 : 1.0)
	}
}
