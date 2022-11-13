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
	@Environment(\.managedObjectContext) var moc
	
	@State private var isAnimating: Bool = false
	@State var buttonText = "Tap to Flip"
	@State var symbolImage = "trash"
	@State var showingDeleteAlert = false
	 var deleteText = """
	Are you sure?
	- this will delete all related notes -
	"""
	@State var frontTravel = 0.0
	@State var rearTravel = 0.0
	@State var strokeLength = 0.0

	@ObservedObject var bike: Bike
	
// MARK: - BODY -
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
						
                    
					
					// BIKE: NAME
					Text(self.bike.name ?? "Unknown")
						.foregroundColor(Color.white)
						.font(.largeTitle)
						.fontWeight(.heavy)
						.customTextShadow()
					
					// BIKE: DETAILS
					Text(self.bike.bikeNote ?? "")
						.foregroundColor(Color.white)
						.font(.caption)
						.multilineTextAlignment(.center)
						.padding(.horizontal, 16)
						.frame(maxWidth: 480)
						.padding(.bottom, 2)
					
					VStack {
						HStack{
							Text(self.bike.frontSetup?.info ?? "")
							Text("\(frontTravel, specifier: "%.0f")mm")
						}
						
						if self.bike.hasRearShock == true {
							HStack {
								Text(self.bike.rearSetup?.info ?? "")
								Text("\(rearTravel, specifier: "%.2f")mm")
							}
							Text("Stroke Length : \(strokeLength, specifier: "%.2f")mm")
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
			.onAppear(perform: {self.setup()})
            .customBackgroundGradient()
			.cornerRadius(20)
			.padding(.horizontal, 20)
			.customShadow()
			// Show the Alert to delete the Bike
			.alert(isPresented: $showingDeleteAlert) {
				Alert(title: Text("Delete Bike"), message: Text("\(deleteText)"), primaryButton: .destructive(Text("Delete")) {
					self.deleteBike()
				}, secondaryButton: .cancel())
			}
	}
	
	
	func deleteBike() {
		moc.delete(bike)
		try? self.moc.save()
		hapticSuccess()
	}
	
	func setup() {
		if (self.bike.frontSetup?.travel) != nil {
			frontTravel = self.bike.frontSetup!.travel
		}
		if (self.bike.rearSetup?.strokeLength) != nil {
			strokeLength = self.bike.rearSetup!.strokeLength
		}
		
		if (self.bike.rearSetup?.rearTravel) != nil {
			rearTravel = self.bike.rearSetup!.rearTravel
		}
	}
}
