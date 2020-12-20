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
