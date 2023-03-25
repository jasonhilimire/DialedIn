//
//  ContentView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData



struct NotesListView: View {
// MARK: - PROPERTIES -
	
       // Create the MOC
    @Environment(\.managedObjectContext) var moc
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>

    @State private var showingAddScreen = false
	@State private var showFavorites = false
	@State private var pickerChoice = ["All", "Favorites"]
//	@State private var pickerChoiceIndex = 0
    @Binding var pickerChoiceIndex: Int
//	@State private var searchText = ""
    @Binding var searchText: String
    @State var createText = "Please create a Bike to begin using Dialed In!"
	
    var body: some View {
// MARK: - BODY -
        VStack {
            VStack{
                if bikes.count == 0 {
                    CreateBikeView(createText: $createText)
                }
                SearchBarView(text: $searchText)
                    .padding([.leading, .trailing])
                    .padding(.top, 5)
                
                Picker("Service Type", selection: $pickerChoiceIndex) {
                    ForEach(0..<pickerChoice.count, id: \.self) { index in
                        Text(self.pickerChoice[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .trailing])
                .padding(.bottom, 5)
                .customShadow()
            }
            
            ScrollView {
                if pickerChoiceIndex == 0 {
                    FilteredNoteView(filter: false, searchText: $searchText)
                        .padding(.horizontal)
                } else if pickerChoiceIndex == 1 {
                    FilteredNoteView(filter: true, searchText: $searchText)
                        .padding(.horizontal)
                }
            }
        }
            
        .onAppear { UITableView.appearance().separatorStyle = .none } 	// remove the separator
        .navigationBarTitle("Dialed In - Notes")
        .navigationBarItems(
            trailing:
            Button(action: {self.checkBikesExist()
                // leading: EditButton().foregroundColor(Color("TextColor")),  this is for when can figure out onDelete in FiltereNoteView
            }) {
                // only show button if we have a bike
                if bikes.count >= 1 {
                    Image(systemName: "note.text.badge.plus")
                        .foregroundColor(Color("TextColor"))
                        .font(.system(size: 30))
                }
        })
            .sheet(isPresented: $showingAddScreen)  {
                AddNoteView().environment(\.managedObjectContext, self.moc)
        }

    }
	
	func checkBikesExist() {
		if bikes.count >= 1 {
			self.showingAddScreen.toggle()
		} else {
			showingAddScreen = false
		}
	}
}



