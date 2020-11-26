//
//  ContentView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/25/20.
//

import SwiftUI
import CoreData

struct ContentView: View {

	@AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
	
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@EnvironmentObject var quickActionSettings: QuickActionSettings
	
	var body: some View {
		TabView {
			HomeTabView()
				.tabItem {
					Image(systemName: "house")
					Text("Home")
				}
			
			NotesListView()
				.tabItem {
					Image(systemName: "list.dash")
					Text("Notes")
				}
			
			BikesView()
				.tabItem {
					//					Image("mountainbike")
					Image(systemName: "hare")
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

struct QuickActionModel : Identifiable {
	let id = UUID()
	let name: String
	let tag: QuickActionSettings.QuickAction
}

let allQuickActions = [
	QuickActionModel(name: "Add Note", tag: .details(name: "addNote")),
	QuickActionModel(name: "Search",tag: .details(name: "search")),
	QuickActionModel(name: "Add Service", tag: .details(name: "addService")),
	
]
