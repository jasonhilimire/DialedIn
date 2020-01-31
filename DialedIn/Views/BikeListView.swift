//
//  BikeListView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeListView: View {
        
       // Create the MOC
    @Environment(\.managedObjectContext) var moc
    // create a Fetch request for Bike
    @FetchRequest(entity: Bike.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Bike.name, ascending: true)
    ]) var notes: FetchedResults<Notes>
    
    // bool to show the Sheet
    @State private var showingAddScreen = false
    
    var body: some View {

        NavigationView {
            List {
                ForEach(notes, id: \.self) { note in
                    NavigationLink(destination: DetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text("Some fucking text")
                                .font(.headline)
                            Text(note.note ?? "Unknown Note")
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBike)
            }
                .navigationBarTitle("Bikes")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus.circle")
            })
                .sheet(isPresented: $showingAddScreen)  {
                    BikeView().environment(\.managedObjectContext, self.moc)
            }
            
        }
    }
    
    func deleteBike(at offsets: IndexSet) {
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

struct BikeListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeListView()
    }
}
