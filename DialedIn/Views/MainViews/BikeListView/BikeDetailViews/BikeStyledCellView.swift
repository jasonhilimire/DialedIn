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
					
	/// IF SHOW SERVICES HERE WHEN DELETE IT WILL CRASH :( 

//					VStack {
//						Section {
//							ForkLastServicedView(bikeName: $bikeName, fork: self.bike.frontSetup!, bike: self.bike)
//						}
//						Divider()
//						Section{
//
//							if self.bike.hasRearShock == false {
//								Text("HardTail")
//							} else {
//								RearShockLastServicedView(rear: self.bike.rearSetup!, bike: self.bike, bikeName: $bikeName)
//							}
//						}
//					}
					
					Spacer()
				}

				.padding([.top, .leading, .trailing])
				Spacer()
			}
//			.padding(.bottom, 5)
			
		} // END Buttons
			.foregroundColor(Color("TextColor"))
			.background(Color("BackgroundColor"))
			.cornerRadius(4.0)
			// Shadow for left & bottom
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
			// Shadow for right & top
//			.shadow(color: Color("BackgroundColor"), radius: 5, x: 5, y: -5)


			
	} // END Whole Card VStack
	
	
	
	func setup() {
		bikeName = self.bike.name!
	}
}

