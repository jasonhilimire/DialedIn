//
//  HomeTabView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomePageMainView: View {
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
	@State var isFromBikeCard = false
	@State var activeSheet: ActiveSheet?
	@State var flipHorizontally = true
	
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
			GeometryReader { geo in //TODO: remove GEO Reader?
                VStack{
                    VStack {
                        HStack(alignment: .top){
                            HomePageLastNoteView()
                            Spacer()
                            HomePageNotesInfoView()
                        }//: END HSTACK
                        HStack{
                            
                            Button(action: {activeSheet = .addBike }) {
                                Label("Add New Bike", systemImage: "bicycle").scaleEffect(1.5)
                            }
                            .buttonStyle(Nav_Button())
                            
                            Spacer()
                            
                            Button(action: {activeSheet = .addService }) {
                                Label("Add New Service", systemImage: "wrench").scaleEffect(1.5)
                            }
                            .buttonStyle(Nav_Button())
                            
                            Spacer()
                            
                            Button(action: { activeSheet = .addNote}) {
                                Label("Add New Note", systemImage: "note.text.badge.plus").scaleEffect(1.5)
                            }
                            .buttonStyle(Nav_Button())
                        }//: END HSTACK
                    }//: END VSTACK
                    .padding(.horizontal, 10)
                    HomePageBikeCardListView()
                }//: END VSTACK
            }//: END GeoREader
            .navigationBarTitle("Dialed In", displayMode: .inline)
        } //: END NavView
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
	
}



