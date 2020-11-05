//
//  PulsatingPlusButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct PulsatingPlusButtonView: View {
	
	@State private var pulse = false
    var body: some View {
		ZStack {
			Circle()
				.stroke(lineWidth: 5)
				.frame(width: 35, height: 35)
				.foregroundColor(.orange)
				.scaleEffect(pulse ? 1.7 : 1)
				.opacity(pulse ? 0.1 : 0.8)
				.animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).speed(0.8))
				.onAppear(){
					self.pulse.toggle()
				}
			Circle()
				.frame(width: 35, height: 35)
				.foregroundColor(.orange)
			Image(systemName: "plus.circle.fill")
				.font(.system(size: 30))
				.foregroundColor(Color("TextColor"))
		}
    }
}

struct PulsatingPlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PulsatingPlusButtonView()
    }
}
