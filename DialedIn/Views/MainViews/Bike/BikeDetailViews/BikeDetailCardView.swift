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
//					NavigationLink(destination: ServiceView(isFromBikeCard: $isFromBikeCard, bike: bike)) {
//						CircularButtonView(symbolImage: $wrenchImage)
//					}
					Button(action: {
						self.showScreenBool.isShowingService.toggle()
						publishBikeName()
					}) {
						CircularButtonView(symbolImage: $wrenchImage)
					}
					.padding(8)
					.customTextShadow()
					
					Spacer()
//					NavigationLink(destination: EditBikeDetailView(bike: bike)) {
//						CircularButtonView(symbolImage: $symbolImage)
//					}
					Button(action: {
						self.showScreenBool.isShowingEdit.toggle()
						publishBikeName()
					}) {
						CircularButtonView(symbolImage: $symbolImage)
					}
					.padding(8)
					.customTextShadow()
				}
				.padding(8)
				.customTextShadow()
				
				BikeDetailView(bike: bike)
				.foregroundColor(Color.white)
				.multilineTextAlignment(.center)
//				.padding(.bottom, 8)

			} //: VSTACK
//			.padding(.bottom, 8)
		} //: ZSTACK
		
		//			.frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
		.background(Color.gray)
		.cornerRadius(20)
		.padding(.horizontal, 20)
		.customShadow()
	}
	
	func publishBikeName() {
		self.showScreenBool.bikeName = bike.name ?? "Unknown"
		print("Bike name is \(self.showScreenBool.bikeName ) + \(bike.name)")
	}
	
}

