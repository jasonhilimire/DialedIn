//
//  DeleteButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct DeleteButtonView: View {
	@Binding var symbolImage: String
	
    var body: some View {
		HStack(spacing: 8) {
			Image(systemName: symbolImage)
				.imageScale(.large)
				.foregroundColor(.white)

		}
		.padding(.horizontal, 16)
		.padding(.vertical, 10)
		.background(
			Circle().strokeBorder(Color.white, lineWidth: 1.25)
		)
		//: Button
		.accentColor(Color.white)
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
		DeleteButtonView(symbolImage: .constant("trash"))
			.preferredColorScheme(.dark)
			.previewLayout(.sizeThatFits)
    }
}
