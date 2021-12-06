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
	@AppStorage("addUUIDS") private var addUUID: Bool = true
	
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
	@State var isFromBikeCard = false
	@State var activeSheet: ActiveSheet?
	@State var flipHorizontally = true
	
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
		case addNote,
			 addService,
			 addBike
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
//							HomeNoteView()
								.frame(height: geo.size.height / 2.5 )
							HomeServiceView()
								.frame(width: .infinity, height: geo.size.height / 2 )
						}
						.padding()
						.navigationBarTitle("Dialed In")
						.navigationBarItems(trailing: trailingBarItems)
					}
				}//: END Main ZSTACK
			} //: END GEOREADER
		} //: END NAV VIEW
		.onAppear(perform: {self.setup()})
		.navigationViewStyle(StackNavigationViewStyle())
		.sheet(item: $activeSheet) { item in
			switch item {
				case .addNote:
					AddNoteView()
				case .addService:
//					Hardcoded to just pass a first Bike found, but since bool is false it will utilize the Picker
					AddServiceView(isFromBikeCard: $isFromBikeCard, bike: bikes[0])
				case .addBike:
					AddBikeView()
			}
		}
	}
	
	func setup(){
		//TODO: remove before GoLive /
		// add for Services???
		updateNotes()
		updateBikes()
		addUUID = false
	}
	
	func updateNotes() {
		for note in notes {
			note.id = UUID()
			try? self.moc.save()
		}
	}
	
	func updateBikes() {
		for bike in bikes {
			bike.id = UUID()
			bike.frontSetup?.id = UUID()
			bike.rearSetup?.id = UUID()
			try? self.moc.save()
		}
	}
	
	
}
