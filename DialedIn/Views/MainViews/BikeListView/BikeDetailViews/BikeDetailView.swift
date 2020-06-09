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
	
    
	@State private var bikeName = ""
	@State var showServiceScreen = false
	@State var showEditScreen = false

    let bike: Bike
	
    var body: some View {
		VStack{
				VStack {

					Text("Info: \(self.bike.bikeNote ?? "")" )
						.font(.subheadline)
						.fontWeight(.thin)
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
					
				///Service view with animation

						Button(action: {
							withAnimation {
								self.showServiceScreen.toggle()
							}
						}) {
							HStack {
								
							Image(systemName: "wrench")
								.imageScale(.large)
								.rotationEffect(.degrees(showServiceScreen ? 90 : 0))
								.scaleEffect(showServiceScreen ? 1.5 : 1)
								.padding()
								Text("Add Service")
				
						}
					}
					
					if showServiceScreen {
						ServiceView(bike: self.bike)
							.transition(.move(edge: .bottom))
					}
	
					Spacer()
				}
			Spacer()
			Text("Notes")
				.font(.largeTitle)
				.fontWeight(.thin)
			FilteredBikeNotesView(filter: self.bikeName)
			
		}
		.padding()
		.navigationBarTitle(self.bike.name ?? "Unknown Bike")
		.navigationBarItems(trailing: Button(action: {
			withAnimation {
				self.showEditScreen.toggle()
			}
		}) {
				Image(systemName: "pencil.circle").foregroundColor(Color("TextColor"))
					.font(.title)
					.scaleEffect(showEditScreen ? 1.5 : 1)
					.padding()
		})
			.sheet(isPresented: $showEditScreen)  {
				EditBikeDetailView(bike: self.bike).environment(\.managedObjectContext, self.moc)
		}
    }
}



