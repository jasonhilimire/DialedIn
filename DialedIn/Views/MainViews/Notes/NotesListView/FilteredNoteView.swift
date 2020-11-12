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
	
	@State var filter: Bool
	@Binding var searchText : String

	func filterFavorites() -> [Bike] {
		// this filters to only show bikes if they have a favorite prevents showing a section header when there is no favorite for that bike
		let filteredBikes = try! moc.fetch(Bike.bikesFetchRequest())
		let foundBikes = filter ? filteredBikes.filter {$0.notesArray.contains {$0.isFavorite}} : filteredBikes
		return foundBikes
	}
	
//	func filterNotes(filter: Bool, search : String) -> [Notes] {
//		let fetchRequest =  try! moc.fetch(Notes.favoritedNotesFetchRequest(filter: filter))
//		let searched = fetchRequest.contains
//		return searched
//	}
	
    var body: some View {
		ForEach(filterFavorites(), id: \.self) { bike in
			// this filters down to show notes that are favorited if true and then filters again on search text
				let array = bike.notesArray
				let filtered = filter ? array.filter { $0.isFavorite } : array
				let searched = filtered.filter({ searchText.isEmpty ? true : $0.wrappedNote.lowercased().contains(searchText.lowercased()) })
			// TODO: Add ability for filter for wrappedBikeName, wrappedBikeNote
			Section(header: Text(bike.wrappedBikeName)) {
				ForEach(searched, id: \.self) { note in
					NavigationLink(destination: NotesDetailView(note: note)){
						NotesStyleCardView(note: note)
					}
				}
			}
		}
	}
}


