//
//  DeleteButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct CircularButtonView: View {
	@Binding var symbolImage: String
	
    var body: some View {
		HStack(spacing: 8) {
			Image(systemName: symbolImage)
				.imageScale(.large)
				.foregroundColor(.white)
				.frame(width: 28.5, height: 28.5, alignment: .center) // frame allows for constant sizing otherwize SF Symbol images are not same :/

		}
		.padding(.horizontal, 16)
		.padding(.vertical, 10)
		.background(
			Circle().strokeBorder(Color.white, lineWidth: 1.25)
		)
		//: Button
		.accentColor(Color.white)
		.customTextShadow()
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
		CircularButtonView(symbolImage: .constant("wrench"))
			.preferredColorScheme(.dark)
			.previewLayout(.sizeThatFits)
    }
}
