//
//  HomeServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeServiceView: View {
    var body: some View {
		Text("Add Service")
			.font(.title)
			.foregroundColor(Color.white)
			.multilineTextAlignment(.center)
			.frame(maxWidth: .infinity, maxHeight: 150)
			.background(Color.green)
			.cornerRadius(20)
		
		// SHOW THE LAST SERVICE ADDED
		// TAP TO SHOW THE SERVICE View
    }
}

struct HomeServiceView_Previews: PreviewProvider {
    static var previews: some View {
        HomeServiceView()
    }
}
