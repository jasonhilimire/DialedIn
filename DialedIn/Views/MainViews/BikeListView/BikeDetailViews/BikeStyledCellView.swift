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
	
	@State private var showingDeleteAlert = false
	@State private var showingNotesView = false
	@State private var showingServiceView = false
	
	
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		return formatter
	}
	
	let bike: Bike
	
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
				}
				.padding([.top, .leading, .trailing])
				Spacer()
			}
			
			ForkLastServicedView(fork: self.bike.frontSetup!)
			RearShockLastServicedView(rear: self.bike.rearSetup!, bike: bike)

			// Buttons
			HStack(alignment: .bottom) {
				Button(action: {self.showingNotesView.toggle()}) {
					HStack {
						Image(systemName: "square.and.pencil")
						Text("Add Note")
					}
				}
				.sheet(isPresented: self.$showingNotesView)  {
					AddNoteBikeView(front: self.front, rear: self.rear, bike: self.bike).environment(\.managedObjectContext, self.moc)
				}
				Spacer()

				Button(action: {self.showingServiceView.toggle()}) {
					HStack {
						Image(systemName: "wrench")
						Text("Add Service")
					}
				}
				.sheet(isPresented: self.$showingServiceView)  {
					ServiceView(bike: self.bike).environment(\.managedObjectContext, self.moc)
				}
			}
			.padding([.leading, .trailing])
			.padding(.bottom, 10)
			
		} // END Buttons
			.foregroundColor(Color("TextColor"))
			.background(Color("BackgroundColor"))
			.cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
			.shadow(color: Color("ShadowColor"), radius: 5, x: 5, y: -5)
	} // END Whole Card VStack
}

