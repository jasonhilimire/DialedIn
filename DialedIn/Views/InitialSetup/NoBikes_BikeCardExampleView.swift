//
//  NoBikes_BikeCardExampleView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoBikes_BikeCardExampleView: View {
	@State private var isAnimating: Bool = false
	@State var buttonText = "Tap to Flip"
	@State var symbolImage = "trash"
	@State var showingDeleteAlert = false
	var deleteText = """
	Silly... 🤭 This is an example bike!
	** Tap + to create a bike and
	this bike will be removed **
	"""
	
    var body: some View {
		ZStack {
			VStack{
				HStack {
					Spacer()
					Button(action: {
						self.showingDeleteAlert.toggle()
					}) {
						CircularButtonView(symbolImage: $symbolImage)
					}
				}
				.padding(8)
				.customTextShadow()
				
				// BIKE: IMAGE - change these images here so it shows a full suspension or hardtail depending on bike type
				Image("bike")
					.resizable()
					.scaledToFit()
					.customTextShadow()
					.scaleEffect(isAnimating ? 1.0 : 0.6)
					.padding(.horizontal, 10)
					.frame(width: 350, height: 350, alignment: .center)
				
				// BIKE: NAME
				Text("Example Bike")
					.foregroundColor(Color.white)
					.font(.largeTitle)
					.fontWeight(.heavy)
					.customTextShadow()
				
				// BIKE: DETAILS
				Text("Tap the + in the upper right to create a bike & this will bike will be removed")
					.foregroundColor(Color.white)
					.font(.caption)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 16)
					.frame(maxWidth: 480)
				.padding(.horizontal)
					.padding(.bottom, 2)
				
				VStack {
					HStack{
						Text("Rad Fork: ")
						Text("160mm")
					}
					
					HStack {
						Text("Squishy Rear Shock -")
						Text("Stroke Length : 52.5mm")
					}
					
				}
				.foregroundColor(Color.white)
				.multilineTextAlignment(.center)
				.padding(.bottom, 12)
				
				//					// BUTTON:
				ArrowButtonView(buttonText: $buttonText)  // ANIMATED CARD FLIP TO SHOW Services on the backside
				
			} //: VSTACK
			.padding(.bottom, 16)
		} //: ZSTACK
		.onAppear{
			withAnimation(.easeOut(duration: 0.5)) {
				isAnimating = true
			}
		}

		.background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red
		]) , startPoint: .top, endPoint: .bottom)))
		.cornerRadius(20)
		.padding(.horizontal, 20)
		.customShadow()
		
		// Show the Alert
		.alert(isPresented: $showingDeleteAlert) {
			Alert(title: Text("Delete Bike"), message: Text("\(deleteText)"), primaryButton: .destructive(Text("Delete")) {
				//
			}, secondaryButton: .cancel()
			)
		}
    }
}

struct NoBikes_BikeCardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_BikeCardExampleView()
    }
}
