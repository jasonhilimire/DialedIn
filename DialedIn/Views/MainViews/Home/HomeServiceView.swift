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
				.padding(.top)
				.padding(.horizontal, (fullView.size.width - 270) / 2)
				.customShadow()
			}
		}
		.edgesIgnoringSafeArea(.all)
	}
}


// MARK: - HomeStyledCardView -
struct HomeStyledCardView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var showScreenBool: BoolModel
	
	@State private var bikeName = ""
	@State private var isFromBikeCard = true
	
	let bike: Bike

	var body: some View {
		VStack {
			Text(self.bike.name ?? "Unknown Bike")
				.fontWeight(.heavy)
				.customTextShadow()
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
		} //: END VSTACK
		.frame(width: 300, height: 275)
		.foregroundColor(Color("TextColor"))
		.background(Color("BackgroundColor"))
		.cornerRadius(20)
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.orange, lineWidth: 2))
		.customShadow()
		.contextMenu {
			VStack {
				Button(action: {
					self.showScreenBool.isShowingService.toggle()
					publishBikeName()
				}) {
					HStack {
						Text("Add Service")
						Image(systemName: "wrench")
						}
					}
				Button(action: {
					self.showScreenBool.isShowingEdit.toggle()
					publishBikeName()
				}) {
					HStack {
						Text("Edit Bike")
						Image(systemName: "doc.badge.gearshape")
					}
				}
			}  //: END VSTACK
		} //: END CONTEXT

		// nested background view to show 2 sheets in same view...
		.background(EmptyView().sheet(isPresented: $showScreenBool.isShowingService) {
			ServiceView(isFromBikeCard: $isFromBikeCard, bike: bike)
				.environmentObject(self.showScreenBool)
				.environment(\.managedObjectContext, self.moc)
		}
		.background(EmptyView().sheet(isPresented: $showScreenBool.isShowingEdit) {
			EditBikeDetailView()
				.environmentObject(self.showScreenBool)
				.environment(\.managedObjectContext, self.moc)
		}))
	} //: END VIEW
	
	func publishBikeName() {
		self.showScreenBool.bikeName = bike.name ?? "Unknown"
	}
}




