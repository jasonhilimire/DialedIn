//
//  BikeStyledCellView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/14/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData
import Combine


struct BikeStyledCellView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var front = NoteFrontSetupModel()
	@ObservedObject var rear = NoteRearSetupModel()
	@ObservedObject var frontShock = FrontServiceModel()
	
	@State private var showingDeleteAlert = false
	@State private var showingNotesView = false
	@State private var showingServiceView = false
	@State private var bikeName = ""
	
	
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		return formatter
	}
	
	let bike: Bike
	
	init(bike: Bike) {
		self.bike = bike
		bikeName = self.bike.name!
	}
	
    var body: some View {
		VStack { // Whole Card
			HStack { // Name - note
				VStack(alignment: .leading) {
					Text(self.bike.name ?? "Unknown")
						.font(.largeTitle)
						.fontWeight(.ultraLight)
					
					Text(self.bike.bikeNote ?? "")
						.font(.callout)
						.fontWeight(.ultraLight)
					.onAppear(perform: {self.setup()})
				}
					
				.padding([.top, .leading, .trailing])
				Spacer()
			}
			
			
//				
//				ForkLastServicedView(bike: bike, fork: self.bike.frontSetup!, bikeName: $bikeName)
//			
//				Divider()
//				RearShockLastServicedView(rear: self.bike.rearSetup!, bike: bike)
			

			.padding(.bottom, 10)
			
		} // END Buttons
			.foregroundColor(Color("TextColor"))
			.background(Color("BackgroundColor"))
			.cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
			.shadow(color: Color("ShadowColor"), radius: 5, x: 5, y: -5)
			
	} // END Whole Card VStack
	
	
	
	func setup() {
		bikeName = self.bike.name!
//		print("Bikename: \(bikeName)")
		frontShock.filterFront(for: bikeName)
	}
}

