//
//  HomeTabView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
	// MARK: - PROPERTIES -
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>

	
	@State var showAddNoteScreen = false
	@State var showAddServiceScreen = false

	// MARK: - BODY -
    var body: some View {
		NavigationView() {
			GeometryReader { geo in
				ZStack {
					if bikes.count == 0 {
						CreateBikeView()
					}
					VStack{
						ZStack {
							LastNoteView() // if notes break and not updating was using HomeNoteViewHere() and note the above check for bikes
								
								.frame(height: geo.size.height / 2.5 )
						}
								
						GeometryReader { innergeo in
							HStack {
								Button(action: {
									self.showAddServiceScreen.toggle()
								}) {
									HStack {
										Image(systemName: "wrench")
										Text("Add Service")
									}
									.sheet(isPresented: $showAddServiceScreen)  {
										ServiceView().environment(\.managedObjectContext, self.moc)
									}
								}.buttonStyle(GradientButtonStyle())
								.frame(width: innergeo.size.width / 2, height: 15)
								
								Spacer()
								Button(action: {
									print("Add Note Pressed")
									self.showAddNoteScreen.toggle()
									
								}) {
									HStack {
										Image(systemName: "gauge.badge.plus")
										Text("Add Note")
									}
									.sheet(isPresented: $showAddNoteScreen)  {
										AddNoteView().environment(\.managedObjectContext, self.moc)
									}
								}.buttonStyle(GradientButtonStyle())
								.frame(width: innergeo.size.width / 2, height: 15)

							} //: END HSTACK
							.frame(width: .infinity, height: geo.size.height / 9 )
						}
						HomeServiceView()
							.frame(width: .infinity, height: geo.size.height / 2.3 )
					}
					.padding()
					.navigationBarTitle("Dialed In")
				} //: END Main ZSTACK
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
    }
	
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
