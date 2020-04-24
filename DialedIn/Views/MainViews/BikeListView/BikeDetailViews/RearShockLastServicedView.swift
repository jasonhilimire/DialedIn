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
    
    let rear: RearShock
	let bike: Bike
	@ObservedObject var rearService = RearServiceModel()
	@Binding var bikeName: String
	
    var body: some View {
		VStack { // Rear Section
			if rear.bike?.hasRearShock == false {
				HStack {
					Text("")
					Spacer()
				}
			} else {
				HStack {
					Text("Rear")
						.font(.headline)
						.fontWeight(.light)
					Spacer()
				}
				.padding(.horizontal)
				if rear.bike?.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
						.fontWeight(.thin)
						Spacer()
						Text("\(self.rearService.getAirCanDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.thin)
					}
					.padding(.horizontal)
					.font(.footnote)
					HStack {
						Text("Last Full Service:")
						.fontWeight(.thin)
						Spacer()
						Text("\(self.rearService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.thin)
					}
					.padding(.horizontal)
					.font(.footnote)
				} else {
					HStack {
						Text("Last Full Service:")
						.fontWeight(.thin)
						Spacer()
						Text("\(self.rearService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.thin)
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

