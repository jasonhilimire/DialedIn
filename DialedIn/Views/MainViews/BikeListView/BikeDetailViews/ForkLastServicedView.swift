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
	
    let fork: Fork
	let bike: Bike
	
	init(bike: Bike, fork: Fork, bikeName: Binding<String>) {
		self.bike = bike
		self.fork = fork
		self._bikeName = bikeName

	}
	
    var body: some View {
		VStack { // Fork Section
			HStack {
				Text("Fork")
					.fontWeight(.bold)
				Spacer()
			}
			.padding([.top, .leading])
			HStack(alignment: .center) {
				Text("Lowers Last Serviced:")
				Spacer()
				Text("\(self.frontService.lastLowerService , formatter: dateFormatter)")
			}
			.padding(.horizontal)
			.font(.footnote)
			HStack {
				Text("Last Full Service:")
				Spacer()
				Text("\(self.frontService.lastFullService, formatter: dateFormatter)")
			}
			.padding(.horizontal)
			.font(.footnote)
		}
			
    }
	
	func setup() {
		print("bikename: \(bikeName)")
		bikeName = self.bike.name ?? "Unknown bike"
		print("bikename2: \(bikeName)")
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
	}
}

