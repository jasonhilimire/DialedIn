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
							ForkLastServicedView(bikeName: $bikeName, bike: self.bike)
						}
						Divider()
						Section{
							if self.bike.hasRearShock == false {
								Text("HardTail")
							} else {
								RearShockLastServicedView(bikeName: $bikeName, bike: self.bike)
							}
						}
					}
				}
			Spacer(minLength: 20)

			Text("Last 5 Notes")
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
				Image(systemName: "square.and.pencil").foregroundColor(Color("TextColor"))
					.font(.title)
					.padding()
		})
			.sheet(isPresented: $showEditScreen)  {
				EditBikeDetailView(bike: self.bike).environment(\.managedObjectContext, self.moc)
		}
    }
}



