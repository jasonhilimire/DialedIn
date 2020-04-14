//
//  BikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct BikeDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var front = NoteFrontSetupModel()
	@ObservedObject var rear = NoteRearSetupModel()
	
    
    @State private var showingDeleteAlert = false
	@State private var showingNotesView = false
	@State private var bikeName = ""
	@State var showService = false

    let bike: Bike
	
    var body: some View {
		VStack{
				VStack {
					Text(self.bike.name ?? "Unknown Bike")
						.font(.largeTitle)
						.fontWeight(.bold)
					Text("Info: \(self.bike.bikeNote ?? "")" )
						.font(.subheadline)
					VStack {
						Section {
							ForkLastServicedView(bikeName: $bikeName, fork: self.bike.frontSetup!, bike: self.bike)
						}
						Divider()
						Section{
							
							if self.bike.hasRearShock == false {
								Text("HardTail")
							} else {
								RearShockLastServicedView(rear: self.bike.rearSetup!, bike: self.bike, bikeName: $bikeName)
							}
						}
					}
					
						Button(action: {
							withAnimation {
								self.showService.toggle()
							}
						}) {
							HStack {
								
							Image(systemName: "wrench")
								.imageScale(.large)
								.rotationEffect(.degrees(showService ? 90 : 0))
								.scaleEffect(showService ? 1.5 : 1)
								.padding()
								Text("Add Service")
				
						}
					}
					
					if showService {
						ServiceView(bike: self.bike)
							.transition(.move(edge: .bottom))
					}
						

					Spacer()
				}
			Spacer()
//				ServicesListView(bike: self.bike, bikeName: $bikeName)
//			BikeNotesListView(bike: self.bike)
			FilteredBikeView(filter: self.bikeName)
			
		}
		.padding()

    }
	
	func doStuff() {
		self.showingNotesView.toggle()
	}
}



