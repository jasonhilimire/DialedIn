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
	
	@State var elapsedLowersServiceColor = false
	@State var elapsedFullServiceColor = false
	

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
					Spacer()
					Text( "\(self.frontService.getlowersDate(bike: self.bikeName), formatter: dateFormatter)")
					Text("(\(elapsedLowersService))")
						.foregroundColor(elapsedLowersServiceColor ? nil : Color.red)
				}
				.padding(.horizontal)
				.if(elapsedLowersServiceColor) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
				.background(elapsedLowersServiceColor ? Color(.red): nil)

			
				HStack {
					Text("Last Full Service:")
					Spacer()
					Text("\(self.frontService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
					Text("(\(elapsedFullService))")
						.foregroundColor(elapsedFullServiceColor ? nil: Color.red)
				}
				.padding(.horizontal)
				.if(elapsedFullServiceColor) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
				.background(elapsedFullServiceColor ? Color(.red): nil)
				

				
			
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
			elapsedLowersServiceColor.toggle()
		}
		
		if elapsedFullService > 20 {
			elapsedFullServiceColor.toggle()
		}
	}
}

