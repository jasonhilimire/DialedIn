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
    // create a Fetch request for Race
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Notes.date, ascending: true)
    ]) var notes: FetchedResults<Notes>
    
    
    @State private var showingAddScreen = false
    
    var body: some View {

        NavigationView {
            List {
                ForEach(notes, id: \.self) { note in
                    NavigationLink(destination: DetailView(note: note)) {
    //                            EmojiRatingView(rating: note.rating)
    //                                .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text("Some fucking text")
                                .font(.headline)
                            Text(note.note ?? "Unknown Note")
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteNotes)
            }
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
    
    func deleteNotes(at offsets: IndexSet) {
        for offset in offsets {
            // find this note in our fetch request
            let note = notes[offset]
            // delete it from the context
            moc.delete(note)
        }
        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
