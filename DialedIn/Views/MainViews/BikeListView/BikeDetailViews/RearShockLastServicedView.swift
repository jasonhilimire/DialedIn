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
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let rear: RearShock
	let bike: Bike
	@ObservedObject var rearService = RearServiceModel()
	@State private var bikeName = ""
	
    var body: some View {
		VStack { // Rear Section
			if rear.bike?.hasRearShock == false {
				Text("")
			} else {
				HStack {
					Text("Rear")
						.fontWeight(.bold)
					Spacer()
				}
				.padding([.top, .leading])
				if rear.bike?.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
						Spacer()
						Text("\(self.rearService.lastAirServ, formatter: self.dateFormatter)")
					}
					.padding([.leading, .trailing])
					.font(.footnote)
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text("\(self.rearService.lastFullServ, formatter: self.dateFormatter)")
					}
					.padding(.horizontal)
					.font(.footnote)
				} else {
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text("\(self.rearService.lastFullServ, formatter: self.dateFormatter)")
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
//		print("Full service \(self.rearService.lastFullServ)")
	}
}

