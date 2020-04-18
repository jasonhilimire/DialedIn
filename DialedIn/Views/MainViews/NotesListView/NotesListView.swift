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
    
    var body: some View {

        NavigationView {
            List{
				NoteStyledCellView()
					.padding([.bottom, .top], 10)
            }

	// remove the separator
			.onAppear { UITableView.appearance().separatorStyle = .none }
            .navigationBarTitle("DialedIn")
                .navigationBarItems(leading: EditButton().foregroundColor(Color.white), trailing:
                Button(action: {self.showingAddScreen.toggle()
                }) {
                    //TODO: DISABLE BUTTON IF BIKE.COUNT IS EMPTY
                    Image(systemName: "gauge.badge.plus")
						.foregroundColor(Color.white)
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
