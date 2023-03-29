//
//  RearShockLastServicedView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/20/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct RearShockLastServicedView: View {
	
    @Environment(\.managedObjectContext) var moc
    
	@ObservedObject var rearService = RearServiceViewModel()
	
	let bike: Bike
	
	init(bike: Bike){
		self.bike = bike
		rearService.getLastServicedDates(bike: bike.wrappedBikeName)
	}
	
    var body: some View {
		VStack (alignment: .leading) { // Rear Section
			if self.bike.hasRearShock  == false {
				HStack {
					Text("")
					Spacer()
				}
			} else {
				HStack {
					Image("shock-absorber")
						.resizable()
						.frame(width: 25, height: 25)
						.scaledToFit()
                    VStack(alignment: .leading) {
						Text("\(self.bike.rearSetup?.info ?? "") - \(self.bike.rearSetup?.rearTravel ?? 0.0 , specifier: "%.2f")mm")
							.font(.headline)
							.fontWeight(.semibold)
						Text("Stroke: \(self.bike.rearSetup?.strokeLength ?? 0.0 , specifier: "%.2f")mm")
							.font(.headline)
							.fontWeight(.semibold)
					}
				}
				.padding(.horizontal)
				.customTextShadow()
				
				if self.bike.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
						Spacer()
						Text("\(self.rearService.airCanServicedDate, formatter: dateFormatter)")
						Text("(\(rearService.elapsedAirCanServiceDays))")
							.foregroundColor(rearService.elapsedAirCanServiceWarning ? nil: Color.red)
					}
					.padding(.horizontal)
					.if(rearService.elapsedAirCanServiceWarning) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
					.background(rearService.elapsedAirCanServiceWarning ? Color(.red): nil)
					
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text("\(self.rearService.fullServiceDate, formatter: dateFormatter)")
						Text("(\(rearService.elapsedFullServiceDays))")
							.foregroundColor(rearService.elapsedFullServiceWarning ? nil: Color.red)
					}
					.padding(.horizontal)
					.if(rearService.elapsedFullServiceWarning) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
						.background(rearService.elapsedFullServiceWarning ? Color(.red): nil)
					
				} else {
					HStack {
						Text("Last Full Service:")
							
						Spacer()
						Text("\(self.rearService.fullServiceDate, formatter: dateFormatter)")
						Text("(\(rearService.elapsedFullServiceDays))")
							.foregroundColor(rearService.elapsedFullServiceWarning ? nil: Color.red)
					}
					.padding(.horizontal)
					.if(rearService.elapsedFullServiceWarning) { $0.customFootnoteBold() } else: { $0.font(.footnote) }
						.background(rearService.elapsedFullServiceWarning ? Color(.red): nil)
				}
				HStack {
					Text("\(self.rearService.serviceNote)")
						.fontWeight(.light)
				}
				.padding(.horizontal)
				.font(.footnote)
			}
		}
    }
}

