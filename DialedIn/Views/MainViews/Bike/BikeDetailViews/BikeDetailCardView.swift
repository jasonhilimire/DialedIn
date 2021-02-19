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
	@EnvironmentObject var showScreenBool: BoolModel
	
	@State var wrenchImage = "wrench"
	@State var symbolImage = "square.and.pencil"
	@State var isFromBikeCard = true
	


	let bike: Bike
	
	// MARK: - BODY -
	var body: some View {
		ZStack {
			VStack{
				HStack {
					Button(action: {
						
						self.showScreenBool.isShowingService.toggle()
						publishBikeName()
					}) {
						CircularButtonView(symbolImage: $wrenchImage)
					}

					Spacer()
					
					Button(action: {
						
						self.showScreenBool.isShowingEdit.toggle()
						publishBikeName()

					}) {
						CircularButtonView(symbolImage: $symbolImage)
					}
				}
				.padding(8)
				.customTextShadow()
				
				BikeDetailView(bike: bike)
					.foregroundColor(Color.white)
					.multilineTextAlignment(.center)

			} //: VSTACK
		} //: ZSTACK
		.background(Color.gray)
		.cornerRadius(20)
		.padding(.horizontal, 20)
		.customShadow()
		

	}
	
	func publishBikeName() {
		self.showScreenBool.bikeName = bike.name ?? "Unknown"
		
	}
	
}

