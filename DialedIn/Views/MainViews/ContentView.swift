//
//  ContentView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData



struct ContentView: View {
    
       // Create the MOC
    @Environment(\.managedObjectContext) var moc
    // create a Fetch request for Notes
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Notes.date, ascending: true)
    ]) var notes: FetchedResults<Notes>
    
    
    @State private var showingAddScreen = false
    
    var body: some View {

        NavigationView {
            VStack {
//                RatingView()
                NoteCellView()
                    .navigationBarTitle("DialedIn")
                .navigationBarItems(leading: EditButton(), trailing:
                    Button(action: {self.showingAddScreen.toggle()
                    }) {
                        Image(systemName: "gauge.badge.plus")
                })
                    .sheet(isPresented: $showingAddScreen)  {
                        AddNoteView().environment(\.managedObjectContext, self.moc)
                }
            }
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
