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
    
       // Create the MOC
    @Environment(\.managedObjectContext) var moc
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>

    @State private var showingAddScreen = false
	@State private var showFavorites = false
	@State private var pickerChoice = ["All", "Favorites"]
	@State private var pickerChoiceIndex = 0	
	
    var body: some View {
		NavigationView {
			VStack {
				Picker("Service Type", selection: $pickerChoiceIndex) {
					ForEach(0..<pickerChoice.count) { index in
						Text(self.pickerChoice[index]).tag(index)
						}
					}.pickerStyle(SegmentedPickerStyle())
						.padding([.leading, .trailing])
						.padding(.top, 5)
					
				if bikes.count == 0 {
					Text("Please Create a Bike!")
						.font(.largeTitle)
						.fontWeight(.thin)
				}
				List{
					if pickerChoiceIndex == 0 {
						FilteredNoteView(filter: false)
					} else if pickerChoiceIndex == 1 {
						FilteredNoteView(filter: true)
					}
				}
			}
				
	// remove the separator
			.onAppear { UITableView.appearance().separatorStyle = .none }
            .navigationBarTitle("Dialed In")
                .navigationBarItems(
					trailing:
                Button(action: {self.showingAddScreen.toggle()
					// leading: EditButton().foregroundColor(Color("TextColor")),  this is for when can figure out onDelete in FiltereNoteView
                }) {
					// only show button if we have a bike
					if bikes.count >= 1 {
                    Image(systemName: "gauge.badge.plus")
						.foregroundColor(Color("TextColor"))
						.font(.title)
					}
            })
                .sheet(isPresented: $showingAddScreen)  {
                    AddNoteView().environment(\.managedObjectContext, self.moc)
			}
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
