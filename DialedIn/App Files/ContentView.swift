//
//  ContentView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/25/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
	// OnBoarding App Storage
	@AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
	
	// Setup UUID for Models that were created without prior to transition /// remove before go live
	@AppStorage("addUUIDS") private var addUUID: Bool = true
	
	
	// Default settings for user configured Service Warning
	@AppStorage("frontLowersServiceSetting") private var frontLowersServiceSetting: Int = 90
	@AppStorage("frontFullServiceSetting") private var frontFullServiceSetting: Int = 180
	
	@AppStorage("rearAirCanServiceSetting") private var rearAirCanServiceSetting: Int = 90
	@AppStorage("rearFullServiceSetting") private var rearFullServiceSetting: Int = 180
	
	
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	
	var body: some View {
		TabView {
			HomeTabView()
				.tabItem {
					Image(systemName: "house")
					Text("Home")
				}
			
			NotesListView()
				.tabItem {
					Image(systemName: "note.text")
					Text("Notes")
				}
			AddItemsView()
				.tabItem {
					Image(systemName: "plus.rectangle.fill").background(Color.orange)
					Text("Notes")
				}
			
			BikesView()
				.tabItem {
					Image(systemName: "bicycle")
					Text("Bikes")
				}
		}
		.animation(.default)
		.accentColor(Color("TextColor"))
		
		// shows the OnBoarding View
		.sheet(isPresented: $needsAppOnboarding){
			OnBoardingView()
		}
	}
}
