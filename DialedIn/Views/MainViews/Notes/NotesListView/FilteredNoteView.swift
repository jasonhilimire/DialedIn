//
//  FilteredAddNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/25/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

/// Create a fetchrequest for ALL notes sorted by date
/// Use toggle to enable/disable showing favorites
/// pass only favorite notes (sorted by date) into the list


struct FilteredNoteView: View {
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<Notes>
	
	init(filter: Bool?){
		let request: NSFetchRequest<Notes> = Notes.favoritedNotesFetchRequest(filter: filter ?? false)
		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
	}
	

	
    var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
				NavigationLink(destination: NotesDetailView(note: note)){
					NotesStyleCardView(note: note)
				}
			}
		}
}

/*
// Correctly works to sort headers by bikeName but losse ability to show favorites etc - need to somehow filter Bikes with Filtered Notes?
ForEach(bikes, id: \.self) { bike in
Section(header: Text(bike.wrappedBikeName)) {
ForEach(bike.notesArray, id: \.self) { note in
NavigationLink(destination: NotesDetailView(note: note)){
NotesStyleCardView(note: note)
}
}
}
}
}

*/
