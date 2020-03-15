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
                    EmojiRatingView(rating: note.rating)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text(note.bike?.name ?? "Unknown Bike")
                            .font(.headline)
                        Text(note.date != nil ? "\(note.date!, formatter: self.dateFormatter)" : "")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    }
                }
            }
            .onDelete(perform: deleteNotes)
            
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
	/*
	change fetch request to Bikes and change body to below- it will properly show notes under sections, but deletion does not work
			to delete need to find the specific note as FetchRequest and then delete it from the context properly
	
	
	ForEach(bikes, id: \.self) { bike in
		Section(header: Text(bike.wrappedBikeName)) {
			ForEach(bike.notesArray, id: \.self) { note in
			NavigationLink(destination: NotesDetailView(note: note)) {
				EmojiRatingView(rating: note.rating)
					.font(.largeTitle)
				VStack(alignment: .leading) {
					Text(note.date != nil ? "\(note.date!, formatter: self.dateFormatter)" : "")
					Text(note.wrappedNote)
						.font(.callout)
						.foregroundColor(.secondary)
					}
				}
			}
		}
	}
	*/
    
}

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCellView()
    }
}
