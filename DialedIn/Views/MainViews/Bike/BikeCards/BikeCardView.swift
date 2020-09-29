//
//  BikeCardView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeCardView: View {
// MARK: - PROPERTIES -
	@State private var isAnimating: Bool = false
	@State var buttonText = "View"
	
// MARK: - BODY -
    var body: some View {
		ZStack {
			VStack(spacing: 20){
				// BIKE: IMAGE
				Image("bike")
					.resizable()
					.scaledToFit()
					.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
					.scaleEffect(isAnimating ? 1.0 : 0.6)
				
				// BIKE: NAME
				Text("MY BIKE NAME")
					.foregroundColor(Color.white)
					.font(.largeTitle)
					.fontWeight(.heavy)
					.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
				
				// BIKE: DETAILS
				Text("This is some info about my bike")
					.foregroundColor(Color.white)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 16)
					.frame(maxWidth: 480)
				
				// BUTTON: START
				ArrowButtonView(buttonText: $buttonText)
			} //: VSTACK
		} //: ZSTACK
//		.onAppear{
//			withAnimation(.easeOut(duration: 0.5)) {
//				isAnimating = true
//			}
//		}
		.frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
		.background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red
		]) , startPoint: .top, endPoint: .bottom)))
//		.background(LinearGradient(gradient: Gradient(colors: [Color("ColorBlueBerryLight"),Color("ColorBlueBerryDark")]), startPoint: .top, endPoint: .bottom))
		.cornerRadius(20)
		.padding(.horizontal, 20)
    }
}


// MARK: - PREVIEW -
struct BikeCardView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCardView()
			.previewLayout(.fixed(width: 320, height: 640))
    }
}
