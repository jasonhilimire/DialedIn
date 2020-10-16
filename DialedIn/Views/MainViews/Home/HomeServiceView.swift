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
		if bikes.count == 0 {
			EmptyView() // Create a view here
		}
		GeometryReader { fullView in
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(bikes, id: \.self) { bike in
						GeometryReader { geo in
							HomeStyledCardView(bike: bike)
								.rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
						}
						.frame(width: 270) // used a smaller width than the 300 for the card so can see the edge
					}
				}
				.padding(.horizontal, (fullView.size.width - 270) / 2)
			}
		}
		.edgesIgnoringSafeArea(.all)
	}
}


// MARK: - HomeStyledCardView -
struct HomeStyledCardView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@State private var bikeName = ""

	let bike: Bike

	var body: some View {
		VStack {
			Text(self.bike.name ?? "Unknown Bike")
				.fontWeight(.heavy)
				.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
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
		.frame(width: 300, height: 240)
		.foregroundColor(Color("TextColor"))
		.background(Color("BackgroundColor"))
		.cornerRadius(20)
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.orange, lineWidth: 2))
		.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
		
	}
}




