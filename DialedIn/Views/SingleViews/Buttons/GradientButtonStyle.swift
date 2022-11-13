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
            .customBackgroundGradient()
			.cornerRadius(15.0)
			.scaleEffect(configuration.isPressed ? 0.6 : 1.0)
			.customTextShadow()
			.animation(.spring())
	}
}

