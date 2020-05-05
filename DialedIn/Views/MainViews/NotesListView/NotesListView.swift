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

    @State private var showingAddScreen = false
	@State private var showFavorites = false
	
	
	/// Create a fetchrequest for ALL notes sorted by date
	/// Use toggle to enable/disable showing favorites
	/// pass only favorite notes (sorted by date) into the list
    
    var body: some View {
        NavigationView {
			VStack {
				Toggle(isOn: $showFavorites) {
					Text("Show Only Favorites")
				}.padding()
				List{
//					NoteStyledCellView(showFavorites: $showFavorites)
//						.padding([.bottom, .top], 10)
					FilteredNoteView(filter: showFavorites)
				}
			}
	// remove the separator
			.onAppear { UITableView.appearance().separatorStyle = .none }
            .navigationBarTitle("Dialed In")
                .navigationBarItems(leading: EditButton().foregroundColor(Color("TextColor")), trailing:
                Button(action: {self.showingAddScreen.toggle()
                }) {
                    //TODO: DISABLE BUTTON IF BIKE.COUNT IS EMPTY
                    Image(systemName: "gauge.badge.plus")
						.foregroundColor(Color("TextColor"))
						.font(.title)
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
