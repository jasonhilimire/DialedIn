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
//					NavigationLink(destination: EditBikeDetailView(bike: bike)) {
//						CircularButtonView(symbolImage: $symbolImage)
//					}
					
					
					Button(action: {
						withAnimation {
							
							self.showEditScreen.toggle()
							print("Show Edit Screen \(showEditScreen)")
						}
					}) {
						CircularButtonView(symbolImage: $symbolImage)
					}
					
				}
				.padding(8)
				.customTextShadow()
				
				BikeDetailView(bike: bike)
				.foregroundColor(Color.white)
				.multilineTextAlignment(.center)
				.padding(.bottom, 12)

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
		.customShadow()

		.sheet(isPresented: $showEditScreen)  {
			EditBikeDetailView(bike: self.bike).environment(\.managedObjectContext, self.moc)

		}
	}

}

