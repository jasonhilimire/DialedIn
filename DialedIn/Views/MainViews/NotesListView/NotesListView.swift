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
	
    var body: some View {
        NavigationView {
			VStack {
				Toggle(isOn: $showFavorites) {
					Text("Show Only Favorites")
					.fontWeight(.thin)
				}
					.padding([.leading, .trailing])
					.padding(.top, 5)
				
				List{
					FilteredNoteView(filter: showFavorites)
				}
			}
	// remove the separator
			.onAppear { UITableView.appearance().separatorStyle = .none }
            .navigationBarTitle("Dialed In")
                .navigationBarItems(trailing:
                Button(action: {self.showingAddScreen.toggle()
					// leading: EditButton().foregroundColor(Color("TextColor")),  this is for when can figure out onDelete in FiltereNoteView
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
