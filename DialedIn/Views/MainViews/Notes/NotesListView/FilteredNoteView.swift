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
	@Binding var searchText : String
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>
	
	func filterFavorites() -> [Bike] {
		// this filters to only show bikes if they have a favorite prevents showing a section header when there is no favorite for that bike
		// TODO: Now utilize the search text to filter or be used in a fetch request
		let filteredBikes = try! moc.fetch(Bike.bikesFetchRequest())
		let foundBikes = filteredBikes.filter {$0.notesArray.contains {$0.isFavorite}}
		return foundBikes
	}
	
	func filterSearchText(for search: String) -> [Bike] {
		// kinda working but perhaps use actual fetch so can get fuzzy matching?
		// TODO: Filters correctly! but if you make a change and are still on favorites view it doesnt remove it- minor bug till you change the view
		let filtered = filterFavorites()
		let searched = filtered.filter({ searchText.isEmpty ? true : $0.wrappedBikeName.contains(searchText) })
		return searched
	}
	
	
    var body: some View {
		if filter == true {
			// TODO: refactor this so filterFavorites takes the bool for isFavorite and no need for else statement ??? ??? not sure though as may only show false
			ForEach(filterFavorites(), id: \.self) { bike in
				// this filters down to show notes that are favorited
				let array = bike.notesArray
				let filtered = array.filter { $0.isFavorite }
				Section(header: Text(bike.wrappedBikeName)) {
					ForEach(filtered, id: \.self) { note in
						NavigationLink(destination: NotesDetailView(note: note)){
							NotesStyleCardView(note: note)
						}
					}
				}
			}
		} else {
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
	}
}


