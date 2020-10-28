//
//  BikeDetailCardView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeDetailCardView: View {
	// MARK: - PROPERTIES -
	@Environment(\.managedObjectContext) var moc
	
	@State private var isAnimating: Bool = false
	@State var buttonText = "BACK"
	@State var symbolImage = "square.and.pencil"

	let bike: Bike
	
	// MARK: - BODY -
	var body: some View {
		ZStack {
			VStack{
				HStack {
					Spacer()
					Button(action: {
						// Edit Bike
					}) {
						DeleteButtonView(symbolImage: $symbolImage)
					}
					
				}
				.padding(8)
				
				BikeDetailView(bike: bike)
				.foregroundColor(Color.white)
				.multilineTextAlignment(.center)
				.padding(.bottom, 12)
				
				// BUTTON:
				/// TODO: HIDE BUTTON UNTIL CAN FIGURE OUT HOW TO GET OUT OF ENDLESS LOOP
//				NavigationLink(destination: BikeCardView(bike: bike)) {
//					ArrowButtonView(buttonText: $buttonText)  // ANIMATED CARD FLIP TO SHOW Services on the backside
//				}
				
			} //: VSTACK
			.padding(.bottom, 16)
		} //: ZSTACK
		.onAppear{
			withAnimation(.easeOut(duration: 0.5)) {
				isAnimating = true
			}
		}
		
		//			.frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
		.background(Color.gray)
		.cornerRadius(20)
		.padding(.horizontal, 20)
		.padding(.vertical, 20)
		.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)

	}

}

