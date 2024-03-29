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
	

	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>
	
	@State var filter: Bool
	@Binding var searchText : String

	func filterFavorites() -> [Bike] {
		// this filters to only show bikes if they have a favorite prevents showing a section header when there is no favorite for that bike
		let filteredBikes = try! moc.fetch(Bike.bikesDefaultFirstFetchRequest())
		let foundBikes = filter ? filteredBikes.filter {$0.notesArray.contains {$0.isFavorite}} : filteredBikes
		return foundBikes
	}
	
	func filterNotes(array : [Notes]) -> [Notes] { //TODO: Refactor this into 
		// list of attributes to be searched bike.name, bike.bikeNote, notes.note, // maybe RearShock.info, Fork.info
		let predicate1 = NSPredicate(format: "bike.name contains [cd] %@", searchText)
		let predicate2 = NSPredicate(format: "bike.bikeNote contains [cd] %@", searchText)
		let predicate3 = NSPredicate(format: "note contains [cd] %@", searchText)
		let predicate4 = NSPredicate(format: "bike.frontSetup.info contains [cd] %@", searchText)
		let predicate5 = NSPredicate(format: "bike.rearSetup.info contains [cd] %@", searchText)
		
		// use compound predicate to search through all predicates
		let compoundPredicate = NSCompoundPredicate(
			orPredicateWithSubpredicates: [predicate1, predicate2, predicate3, predicate4, predicate5]
		)
		
		// filter the array based on isFavorite - then the searchText
		let filtered = filter ? array.filter { $0.isFavorite } : array
		let compoundPredicateResult = filtered.filter { searchText.isEmpty ? true : compoundPredicate.evaluate(with:$0) }
		let sortedbyDateResults = compoundPredicateResult.sorted(by: {$0.date ?? Date() > $1.date ?? Date()})
		return sortedbyDateResults
	}
	
	
	
    var body: some View {
        ForEach(filterFavorites(), id: \.self) { bike in
            let array = bike.notesArray
            if array.count > 0 {
                let filteredArray = filterNotes(array: array)
                if filteredArray.count > 0 {
                    Section(header: HStack {
                        Text(bike.wrappedBikeName)
                            .font(.headline)
                            .foregroundColor(Color("TextColor"))
                            .padding()
                        Spacer()
                        Text("\(filteredArray.count)")
                            .font(.headline)
                            .foregroundColor(Color("TextColor"))
                            .padding(10)
                    }
                    .background(Color("TextEditBackgroundColor"))) {
                        ForEach(filteredArray, id: \.self) { note in
                            NavigationLink(destination: NotesDetailView(note: note)){
                                NotesStyleCardView(note: note)
                            }
                        }
                    }
                }
            }
        }
    }
}


