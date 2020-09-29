//
//  SaveToastView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 5/14/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct SaveToastView: View {
    var body: some View {
		ZStack {
			HStack {
				Text("Saved!")
			}
		.padding()
			.foregroundColor(Color("TextColor"))
			.background(Color.orange)
			.cornerRadius(8)
		}
    }
}

struct SaveToastView_Previews: PreviewProvider {
    static var previews: some View {
        SaveToastView()
    }
}
