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
			GeometryReader { geo in
				ZStack {
						VStack{
                            VStack {
                                HStack(alignment: .top){
                                    LastNoteView()
                                        .frame(width: (geo.size.width / 2),   height: geo.size.height / 2.5 )
                                    Spacer()
                                    InfoView()
                                        .frame(width: (geo.size.width / 2),   height: geo.size.height / 4 )
                                }//: END HSTACK
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2))
                                
                                HStack{
                                    Button(action: { activeSheet = .addNote}) {
                                        Label("Add New Note", systemImage: "note.text.badge.plus")
                                    }
                                    .buttonStyle(Nav_Button())
                                    
                                    Spacer()
                                    
                                    Button(action: {activeSheet = .addService }) {
                                        Label("Add New Service", systemImage: "wrench")
                                    }
                                    .buttonStyle(Nav_Button())
                                    
                                    Spacer()
                                    
                                    Button(action: {activeSheet = .addBike }) {
                                        Label("Add New Bike", systemImage: "bicycle")
                                    }
                                    .buttonStyle(Nav_Button())
                                    
                                }//: END HSTACK
                                .frame(width: geo.size.width)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2))
                            }//: END VSTACK
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2))
							HomeServiceView()
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2))
						}//: END VSTACK
						.navigationBarTitle("Dialed In")
					}//: END ZSTACK
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2))
                .padding(.horizontal)
				}//: END GeoREader
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



