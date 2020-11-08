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
	
//	var fetchRequest: FetchRequest<Notes>
//
//	init(filter: Bool?){
//		let request: NSFetchRequest<Notes> = Notes.favoritedNotesFetchRequest(filter: filter ?? false)
//		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
//	}
	
	@State var filter: Bool
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>
	

	
    var body: some View {
//		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
//				NavigationLink(destination: NotesDetailView(note: note)){
//					NotesStyleCardView(note: note)
//				}
//			}
		
		ForEach(bikes, id: \.self) { bike in
			Section(header: Text(bike.wrappedBikeName)) {
				let array = bike.notesArray
				let filtered = array.filter { $0.isFavorite } // this works but will show bike names that dont have favorites
				if filter == true {
				ForEach(filtered, id: \.self) { note in
					NavigationLink(destination: NotesDetailView(note: note)){
						NotesStyleCardView(note: note)
						}
					}
				} else {
					ForEach(array, id: \.self) { note in
						NavigationLink(destination: NotesDetailView(note: note)){
							NotesStyleCardView(note: note)
						}
					}
				}
			}
		}
	}
}


