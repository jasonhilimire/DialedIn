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
    
	@ObservedObject var rearService = RearServiceModel()
	@Binding var bikeName: String
	
	@State var elapsedAirService = 0
	@State var elapsedFullService = 0
	
	let bike: Bike
	
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
					Text("\(self.bike.rearSetup?.info ?? "") - \(self.bike.rearSetup?.strokeLength ?? 0.0 , specifier: "%.2f")mm")
						.font(.headline)
						.fontWeight(.semibold)
				}
				.padding(.horizontal)
				.customTextShadow()
				
				if self.bike.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
							.fontWeight(.light)
						Spacer()
						Text("\(self.rearService.getAirCanDate(bike: self.bikeName), formatter: dateFormatter)")
							.fontWeight(.light)
						Text("(\(elapsedAirService))")
							.foregroundColor(Color.red)
					}
					.padding(.horizontal)
					.font(.footnote)
					
					HStack {
						Text("Last Full Service:")
							.fontWeight(.light)
						Spacer()
						Text("\(self.rearService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
							.fontWeight(.light)
						Text("(\(elapsedFullService))")
							.foregroundColor(Color.red)
					}
					.padding(.horizontal)
					.font(.footnote)
					
					HStack {
						Text("\(self.rearService.getRearServiceNote(bike: self.bikeName))")
							.fontWeight(.light)
					}
					.padding(.horizontal)
					.font(.footnote)
					
				} else {
					HStack {
						Text("Last Full Service:")
							.fontWeight(.light)
						Spacer()
						Text("\(self.rearService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
							.fontWeight(.light)
						Text("(\(elapsedFullService))")
							.fontWeight(.light)
							.foregroundColor(Color.red)
					}
					.padding(.horizontal)
					.font(.footnote)
					
					HStack {
						Text("\(self.rearService.getRearServiceNote(bike: self.bikeName))")
							.fontWeight(.light)
					}
					.padding(.horizontal)
					.font(.footnote)
				}
			}
		} .onAppear(perform: {self.setup()})
    }
	
	
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		rearService.bikeName = bikeName
		rearService.getLastServicedDates()
		
		elapsedAirService = daysBetween(start: self.rearService.lastAirServ, end: Date())
		elapsedFullService = daysBetween(start: self.rearService.lastFullServ, end: Date())

	}
}

