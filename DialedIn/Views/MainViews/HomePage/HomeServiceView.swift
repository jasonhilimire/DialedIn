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
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(bikes, id: \.self) { bike in
                    NavigationLink(destination: BikeDetailView(bike: bike)){
                        HomeStyledCardView(bike: bike)
                    }
                }
                .padding(.top, 5)
                .padding(.horizontal, 10)
            }
            .customShadow()
            }
        }
    }




// MARK: - HomeStyledCardView -
struct HomeStyledCardView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var showScreenBool: BoolModel
	
	@StateObject var bikeVM = BikeViewModel()
	
	@State private var isFromBikeCard = true
	@State private var showServiceView = false
	@State private var showEditBikeDetailView = false
	
	let bike: Bike
    @State var frontTravel = 0.0
    @State var rearTravel = 0.0
    @State var strokeLength = 0.0

	var body: some View {
        HStack{
            Image("bike")
                .resizable()
                .scaledToFit()
                .customTextShadow()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.horizontal, 10)
            VStack(alignment: .leading){
                HStack{
                    Text(self.bike.name ?? "Unknown Bike")
                        .fontWeight(.heavy)
                    Spacer()
                }//: END HSTACK
                HStack{
                    Text(self.bike.frontSetup?.info ?? "")
                    Text("\(frontTravel, specifier: "%.0f")mm")
                }
                
                if self.bike.hasRearShock == true {
                    HStack {
                        Text(self.bike.rearSetup?.info ?? "")
                        Text("\(rearTravel, specifier: "%.2f")mm")
                    }
                    Text("Stroke Length : \(strokeLength, specifier: "%.2f")mm")
                }
            }//:END VSTACK
            Spacer()
        }//: END HSTACK
        .padding(10)
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
					publishBikeName()
					self.showServiceView.toggle()
				}) {
					HStack {
						Text("Add Service")
						Image(systemName: "wrench")
						}
					}
				Button(action: {
					publishBikeName()
					self.showEditBikeDetailView.toggle()
				}) {
					HStack {
						Text("Edit Bike")
						Image(systemName: "doc.badge.gearshape")
					}
				}
			}  //: END VSTACK
		} //: END CONTEXT

		// nested background view to show 2 sheets in same view...
		.background(EmptyView().sheet(isPresented: $showServiceView) {
			AddServiceView(isFromBikeCard: $isFromBikeCard, bike: bike)
				.environmentObject(self.showScreenBool)
				.environment(\.managedObjectContext, self.moc)
		}
		
		.background(EmptyView().sheet(isPresented: $showEditBikeDetailView) {
			EditBikeDetailView(bike: bike)
				.environmentObject(self.showScreenBool)
				.environment(\.managedObjectContext, self.moc)
		}))
	} //: END VIEW
	
	func publishBikeName() {
		self.showScreenBool.bikeName = bike.name ?? "Unknown"
		bikeVM.getBike(for: showScreenBool.bikeName)
	}
}




