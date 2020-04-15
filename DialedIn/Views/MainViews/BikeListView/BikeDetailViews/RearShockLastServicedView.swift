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
						.fontWeight(.bold)
					Spacer()
				}
				.padding(.horizontal)
				if rear.bike?.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
						Spacer()
						Text("\(self.rearService.getAirCanDate(bike: bikeName), formatter: dateFormatter)")
					}
					.padding(.horizontal)
					.font(.footnote)
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text("\(self.rearService.getFullDate(bike: bikeName), formatter: dateFormatter)")
					}
					.padding(.horizontal)
					.font(.footnote)
				} else {
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text("\(self.rearService.getFullDate(bike: bikeName), formatter: dateFormatter)")
					}
					.padding(.horizontal)
					.font(.footnote)
				}
			}
		}
    }
	

}

