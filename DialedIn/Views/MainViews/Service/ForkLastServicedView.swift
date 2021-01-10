//
//  ForkDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/19/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ForkLastServicedView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var frontService = FrontServiceModel()
	@Binding var bikeName: String
	
	@State var elapsedLowersService = 0
	@State var elapsedFullService = 0
	
	@State var elapsedLowersServiceAnimation = false
	@State var elapsedFullServiceAnimation = false
	

	let bike: Bike
	
	
    var body: some View {
		VStack(alignment: .leading) { // Fork Section
				HStack {
					Image("bicycle-fork")
						.resizable()
						.frame(width: 25, height: 25)
						.scaledToFit()
					Text("\(self.bike.frontSetup?.info ?? "") - \(self.bike.frontSetup?.travel ?? 0.0, specifier: "%.2f")mm")
						.font(.headline)
						.fontWeight(.semibold)
					Spacer()
				}
				.padding([.top, .leading, .trailing])
				.customTextShadow()
				
				HStack(alignment: .center) {
					Text("Lowers Last Serviced:")
						.fontWeight(elapsedLowersServiceAnimation ? .bold : nil)
					Spacer()
					Text( "\(self.frontService.getlowersDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(elapsedLowersServiceAnimation ? .bold : nil)
					Text("(\(elapsedLowersService))")
						.foregroundColor(Color.red)
						.fontWeight(elapsedLowersServiceAnimation ? .bold : nil)
				}
				.padding(.horizontal)
				.font(.footnote)
				.foregroundColor(elapsedLowersServiceAnimation ? .red : nil)
			
				HStack {
					Text("Last Full Service:")
					Spacer()
					Text("\(self.frontService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(elapsedFullServiceAnimation ? .bold : nil)
					Text("(\(elapsedFullService))")
						.foregroundColor(Color.red)
						.fontWeight(elapsedFullServiceAnimation ? .bold : nil)
				}
				.padding(.horizontal)
				.font(.footnote)
				.foregroundColor(elapsedFullServiceAnimation ? .red : nil)  // TODO: OVERWRITING PARENT VIEW THAT SETS COLOR TO WHITE WHEN NIL???
				
			
				HStack {
					Text("\(self.frontService.getFrontServiceNote(bike: self.bikeName))").fontWeight(.light)
				}
				.padding(.horizontal)
				.font(.footnote)
		} .onAppear(perform: {self.setup()})
    }
	
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
		elapsedLowersService = frontService.elapsedLowerServiceDate
		elapsedFullService = frontService.elapsedFullServiceDate
		
		// TODO: USE A REAL SET VALUE - but also if access from BikeCardFlipView this isnt seeting the boolean correctly, when click on hom then back to bikes it working- may need to be an observed object
		if elapsedLowersService > 20 {
			elapsedLowersServiceAnimation.toggle()
		}
		
		if elapsedFullService > 30 {
			elapsedFullServiceAnimation.toggle()
		}
	}
}

