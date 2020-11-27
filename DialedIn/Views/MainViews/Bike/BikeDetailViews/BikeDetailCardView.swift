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
	
	@State var buttonText = "Edit"
	@State var symbolImage = "square.and.pencil"
	@State var showEditScreen = false

	let bike: Bike
	
	// MARK: - BODY -
	var body: some View {
		ZStack {
			VStack{
				HStack {
					Spacer()
					NavigationLink(destination: EditBikeDetailView(bike: bike)) {
						CircularButtonView(symbolImage: $symbolImage)
					}
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
		.sheet(isPresented: $showEditScreen)  {
			EditBikeDetailView(bike: self.bike).environment(\.managedObjectContext, self.moc)
		}
	}
}

