//
//  HomeBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeBikeView: View {
    var body: some View {
		Text("Add Bike")
			.font(.title)
			.foregroundColor(Color.white)
			.multilineTextAlignment(.center)
			.frame(maxWidth: .infinity, maxHeight: 80)
			.background(Color.pink)
			.cornerRadius(20)
		
		// Show ADD A BIKE View
		// ?? What should it show if you have bikes created??
    }
}

struct HomeBikeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBikeView()
    }
}
