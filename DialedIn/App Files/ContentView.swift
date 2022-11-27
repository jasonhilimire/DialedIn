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
	@AppStorage("rearAirCanServiceSetting") private var rearAirCanServiceSetting: Int = 90
	@AppStorage("rearFullServiceSetting") private var rearFullServiceSetting: Int = 180
	
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	
	var body: some View {
        HomePageMainView()
		.accentColor(Color("TextColor"))
		
		// shows the OnBoarding View
		.sheet(isPresented: $needsAppOnboarding){
			OnBoardingView()
		}
	}
}
