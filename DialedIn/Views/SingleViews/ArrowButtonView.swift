//
//  ArrowButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ArrowButtonView: View {
	@Binding var buttonText: String
	
    var body: some View {

			HStack(spacing: 8) {
				Text("\(buttonText)")
				
				Image(systemName: "arrow.right.circle")
					.imageScale(.large)
			}
			.padding(.horizontal, 16)
			.padding(.vertical, 10)
			.background(
				Capsule().strokeBorder(Color.white, lineWidth: 1.25)
			)
		 //: Button
		.accentColor(Color.white)
    }
}

struct ArrowButtonView_Previews: PreviewProvider {
	static var previews: some View {
		ArrowButtonView(buttonText: .constant("View")) // use .constant in place of the binding for previews
			.preferredColorScheme(.dark)
			.previewLayout(.sizeThatFits)
    }
}
