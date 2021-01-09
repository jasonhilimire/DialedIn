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

	@FetchRequest(entity: Notes.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Notes.date, ascending: true)
	]) var notes: FetchedResults<Notes>
	
	@State var showAddNoteScreen = false
	@State var showAddServiceScreen = false
	@State var activeSheet: ActiveSheet?
	@State private var alertIdentifier: AlertIdentifier?
	@State var flipHorizontally = true
	
	@State var showServiceWarning = false
	@State var alertText = "Service has elapsed schedule- Recommend servicing soon!"
	
	// Plus button setup
	var trailingBarItems: some View {
		Menu {
			Button(action: { activeSheet = .addNote}) {
				Label("Add New Note", systemImage: "note.text.badge.plus")
			}
			Button(action: {activeSheet = .addService }) {
				Label("Add New Service", systemImage: "wrench")
			}
			Button(action: {activeSheet = .addBike }) {
				Label("Add New Bike", systemImage: "bicycle")
			}
		} label: {
			Image(systemName: "plus.circle")
				.font(.system(size: 35))
		}
	}
	
	enum ActiveSheet: Identifiable {
		case addNote, addService, addBike
		var id: Int {
			hashValue
		}
	}
	
	enum AlertIdentifier: Identifiable {
		case frontLowers, frontFull, rearAirCan, rearFull
		var id: Int {
			hashValue
		}
	}
	
	// MARK: - BODY -
    var body: some View {
		NavigationView() {
			GeometryReader { geo in
				ZStack {
					if bikes.count == 0 && notes.count == 0 {
						NoBikes_HomeScreenExampleView()
					} else if notes.count == 0 {
						VStack{
							NoBikes_NoteExampleView()
								.frame(height: geo.size.height / 2 )

							HomeServiceView()
								.frame(width: .infinity, height: geo.size.height / 2 )
						}
						.padding()
						.navigationBarTitle("Dialed In")
					} else {
						VStack{
							LastNoteView() // if notes break and not updating was using HomeNoteViewHere() and note the above check for bikes
								.frame(height: geo.size.height / 2.5 )
							HomeServiceView()
								.frame(width: .infinity, height: geo.size.height / 2 )
						}
						.padding()
						.navigationBarTitle("Dialed In")
						.navigationBarItems(trailing: trailingBarItems)
					}
				}//: END Main ZSTACK
				
				.alert(isPresented: $showServiceWarning) {
					switch alertIdentifier {
						case .frontLowers:
							return Alert(title: Text("Lowers Service Needed"), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
								//
							}, secondaryButton: .cancel())
						case .frontFull:
							return Alert(title: Text("Full Fork Service Needed"), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
								//
							}, secondaryButton: .cancel())
						case .rearAirCan:
							return Alert(title: Text("Rear AirCan Service Needed"), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
								//
							}, secondaryButton: .cancel())
						case .rearFull:
							return Alert(title: Text("Full Rear Service Needed"), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
								//
							}, secondaryButton: .cancel())
						case .none:
							return Alert(title: Text("Oops" ), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
								//
							}, secondaryButton: .cancel())
					}
					
				}
			} //: END GEOREADER
		} //: END NAV VIEW
		.navigationViewStyle(StackNavigationViewStyle())
		.sheet(item: $activeSheet) { item in
			switch item {
				case .addNote:
					AddNoteView()
				case .addService:
					ServiceView(bike: nil)
				case .addBike:
					AddBikeView()
			}
		}
		
		/// add some kind of function that checks and sets the alertidentifier if x self.alertIdentifier = .frontLowers
    }
}
