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
    
    @ObservedObject var frontService = FrontServiceViewModel()

	let bike: Bike
	
	init(bike: Bike){
		self.bike = bike
		frontService.getLastServicedDates(bike: bike.wrappedBikeName)
	}
	
	
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
					Text( "\(self.frontService.lowersServiceDate, formatter: dateFormatter)")
					Text("(\(frontService.elapsedLowersServiceDays))")
						.foregroundColor(frontService.elapsedLowersServiceWarning ? nil : Color.red)
				}
				.padding(.horizontal)
				.if(frontService.elapsedLowersServiceWarning) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
				.background(frontService.elapsedLowersServiceWarning ? Color(.red): nil)

			
				HStack {
					Text("Last Full Service:")
					Spacer()
					Text("\(self.frontService.fullServiceDate, formatter: dateFormatter)")
					Text("(\(frontService.elapsedFullServiceDays))")
						.foregroundColor(frontService.elapsedFullServiceWarning ? nil: Color.red)
				}
				.padding(.horizontal)
				.if(frontService.elapsedFullServiceWarning) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
				.background(frontService.elapsedFullServiceWarning ? Color(.red): nil)
				

				HStack {
					Text("\(self.frontService.serviceNote)").fontWeight(.light)
				}
				.padding(.horizontal)
				.font(.footnote)
		}
    }
}

