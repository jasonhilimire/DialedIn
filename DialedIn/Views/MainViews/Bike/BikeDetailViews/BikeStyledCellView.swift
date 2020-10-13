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
						.font(.headline)
						.fontWeight(.thin)
					
					Text(self.bike.bikeNote ?? "")
						.font(.footnote)
						.fontWeight(.ultraLight)
					
					Spacer()
				}
				.onAppear(perform: {self.setup()})
				.padding([.top, .leading, .trailing])
				Spacer()
			}
			
		} // END Buttons
			.foregroundColor(Color("TextColor"))
			.background(Color("BackgroundColor"))
			.cornerRadius(4.0)
			// Shadow for left & bottom
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
	} // END Whole Card VStack
	
	
	
	func setup() {
		bikeName = self.bike.name ?? ""
	}
}
