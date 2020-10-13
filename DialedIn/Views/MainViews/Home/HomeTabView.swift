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
// TODO: WRAP IN A NAVIGATION VIEW? or at least add a custom header
// TODO : ADD BUTTONS To SHOW sheets for adding Notes /  service / bike
		NavigationView() {
			
			if bikes.count == 0 {
				CreateBikeView()
			}
			VStack{
				ZStack {
					LastNoteView() // if notes break and not updating was using HomeNoteViewHere() and note the above check for bikes
				}
				
				HStack {
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
					
					
					Spacer()
					Button(action: {
						print("Add Service Pressed")
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
				}
				HomeServiceView()
			}
			.padding()
			.navigationTitle("Dialed In")
		}
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
