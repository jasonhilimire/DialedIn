//
//  GradientButtonStyle.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/5/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.foregroundColor(Color.white)
			.padding()
			.background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
			.cornerRadius(15.0)
			.scaleEffect(configuration.isPressed ? 1.3 : 1.0)
			.shadow(color: Color("ShadowColor"), radius: 5, x: 1, y: 1)
	}
}
