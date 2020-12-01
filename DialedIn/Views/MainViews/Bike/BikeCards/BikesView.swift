//
//  BikesView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikesView: View {
// MARK: - PROPERTIES -
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>
	
	@EnvironmentObject var showScreenBool: BoolModel
	
	// bool to show the Sheet
	@State private var showingAddScreen = false
	@State private var showingEditScreen = false
	@State var isFromBikeCard = true
	
	// Published if Objects did change- seems to be working, but seems flaky
	@State private var refreshing = false
	private var didChange =  NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)

	
	
// MARK: - BODY -
    var body: some View {
		NavigationView {
			ScrollView {
				if bikes.count == 0 {
					NoBikes_FlipExampleView()
				} else {
					ForEach(bikes, id: \.self) { bike in
						BikeCardFlipView(bike: bike)
					} //: LOOP
					// here is the listener for published context event
					.onReceive(self.didChange) { _ in
						self.refreshing.toggle()
					}
				}
			} //: SCROLLVIEW
			
			.sheet(isPresented: $showingAddScreen)  {
				AddBikeView().environment(\.managedObjectContext, self.moc)
			}
			
			.sheet(isPresented: $showScreenBool.isShowingService)  {
				ServiceView(isFromBikeCard: $isFromBikeCard, bike: nil) // how to pass the proper bike
					.environmentObject(self.showScreenBool)
					.environment(\.managedObjectContext, self.moc)
			}
			
//			.sheet(isPresented: $showScreenBool.isShowingEdit)  {
//				EditBikeDetailView(, bike: <#Bike#>)// how to pass the proper bike?
//					.environmentObject(self.showScreenBool)
//					.environment(\.managedObjectContext, self.moc)
//			}
			
			
			.listStyle(InsetGroupedListStyle())
			.navigationBarTitle("Dialed In - Bikes")
			.navigationBarItems(trailing: Button(action: {self.showingAddScreen.toggle()
			}) {
				if bikes.count == 0 {
					PulsatingPlusButtonView()
				} else {
				Image(systemName: "plus.circle").foregroundColor(Color("TextColor"))
					.font(.system(size: 35))
				}
			})
		}
	}
}

struct BikesView_Previews: PreviewProvider {
    static var previews: some View {
        BikesView()
    }
}
