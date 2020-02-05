//
//  NoteCellView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

// This view is for the notes cell
import SwiftUI

//nested views https://medium.com/swlh/swiftui-create-list-tableview-f3b5499523cf

struct NoteCellView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Notes.date, ascending: true)
    ]) var notes: FetchedResults<Notes>
    
     var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         return formatter
     }
    
    var body: some View {
            ForEach(notes, id: \.self) { note in
                NavigationLink(destination: NotesDetailView(note: note)) {
                    VStack(alignment: .leading) {
                        Text(note.bike?.name ?? "Unknown Bike")
                            .font(.headline)
                        Text(note.note ?? "Some Text goes here")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
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

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCellView()
    }
}
