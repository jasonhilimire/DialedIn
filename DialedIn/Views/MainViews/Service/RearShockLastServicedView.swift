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
					Text("Rear")
						.font(.headline)
						.fontWeight(.semibold)
					Spacer()
					Text("\(self.bike.rearSetup?.info ?? "")")
				}
				.padding(.horizontal)
				if self.bike.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
						.fontWeight(.light)
						Spacer()
						Text("\(self.rearService.getAirCanDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.light)
					}
					.padding(.horizontal)
					.font(.footnote)
					
					HStack {
						Text("Last Full Service:")
						.fontWeight(.light)
						Spacer()
						Text("\(self.rearService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.light)
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
		
		
		print("Full service \(self.rearService.lastFullServ)")
	}
}

