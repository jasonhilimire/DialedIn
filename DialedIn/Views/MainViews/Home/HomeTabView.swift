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
	
	
	var trailingBarItems: some View {
		Menu {
			Button(action: { activeSheet = .addNote}) {
				Label("Add New Note", systemImage: "gauge.badge.plus")
			}
			Button(action: {activeSheet = .addService }) {
				Label("Add New Service", systemImage: "wrench")
			}
			Button(action: {activeSheet = .addBike }) {
				Label("Add New Bike", systemImage: "hare")
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
//							HomeTabButtonsView(showAddServiceScreen: $showAddServiceScreen, showAddNoteScreen: $showAddNoteScreen)
//								.padding(.top, 40)
							HomeServiceView()
								.frame(width: .infinity, height: geo.size.height / 2 )
						}
						.padding()
						.navigationBarTitle("Dialed In")
					} else {
						VStack{
							LastNoteView() // if notes break and not updating was using HomeNoteViewHere() and note the above check for bikes
									.frame(height: geo.size.height / 2 )
//							HomeTabButtonsView(showAddServiceScreen: $showAddServiceScreen, showAddNoteScreen: $showAddNoteScreen)
//								.padding(.top, 40)
							HomeServiceView()
								.frame(width: .infinity, height: geo.size.height / 2 )
						}
						.padding()
						.navigationBarTitle("Dialed In")
						.navigationBarItems(trailing: trailingBarItems)
					}
				}//: END Main ZSTACK
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.sheet(item: $activeSheet) { item in
			switch item {
				case .addNote:
					AddNoteView()
				case .addService:
					ServiceView()
				case .addBike:
					AddBikeView()
			}
		}
    }
	
}

struct HomeTabButtonsView: View {
	// MARK: - PROPERTIES -
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Binding var showAddServiceScreen: Bool
	@Binding var showAddNoteScreen: Bool
	
	var body: some View {
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
		}
	}
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
