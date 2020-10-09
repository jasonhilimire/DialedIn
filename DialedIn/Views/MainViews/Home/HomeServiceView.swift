//
//  HomeServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

// SHOW THE LAST SERVICES ADDED, based on the last bike note added -  maybe set up for 'default bike' (though need to configure defaults so they are only applicable for one bike
// Fetch the last note.bike.name - then feed that into the views that are already configured
// ensure they dont duplicate -
// could also use side scrollable cards sorted by name for bikes on the bottom list?


struct HomeServiceView: View {
	//MARK: - PROPERTIES -
	@Environment(\.managedObjectContext) var moc
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>
	
	
	// MARK: - BODY -
	var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 15) {
				ForEach(bikes, id: \.self) { bike in
					HomeStyledCardView(bike: bike)
				}
			}
		}
	}
}

struct HomeStyledCardView: View {
	@ObservedObject var bike: Bike
	@State private var bikeName = ""
	
	var body: some View {
		
		VStack {
			Text(self.bike.name ?? "Unknown Bike")
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
		}
		.frame(width: 300, height: 250)
		.background(Color.red)
		.cornerRadius(20)
//		.padding(.horizontal, 5)
		.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
	}
}




