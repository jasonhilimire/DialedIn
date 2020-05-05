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
	var fetchRequest: FetchRequest<Notes>
	@Environment(\.managedObjectContext) var moc
	
    var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
				NavigationLink(destination: NotesDetailView(note: note)){
					VStack {
						HStack {
							Text(note.bike?.name ?? "Unknown Bike")
								.fontWeight(.thin)
							Spacer()
							Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
								.fontWeight(.thin)
							FavoritesView(favorite: .constant(note.isFavorite))
						}.font(.title)
						
						VStack(alignment: .leading) {
							HStack {
								VStack(alignment: .leading) {
									
									RatingView(rating: .constant(Int(note.rating)))
									Text(note.note ?? "")
										.font(.footnote)
										.fontWeight(.thin)
								}
								Spacer()
							}
						}
						
						HStack {
							VStack {
								HStack {
									Text("F")
										.fontWeight(.thin)
									Text("\(note.fAirVolume, specifier: "%.1f")")
										.fontWeight(.thin)
								}
								.padding([.top, .bottom, .trailing]) .font(.title)
								
								
								HStack {
									Text("R")
										.fontWeight(.thin)
									Text("\(note.rAirSpring, specifier: "%.0f")")
										.fontWeight(.thin)
								} .padding([.top, .bottom, .trailing])
									.font(.title)
							}
							
							Spacer()
							VStack(alignment: .leading) {
								if note.bike?.frontSetup?.dualRebound == true {
									Text("HSR: \(note.fHSR)")
									Text("LSR: \(note.fLSR)")
								} else {
									Text("Reb: \(note.fRebound)")
									
								}
								Text("Sag %: \(note.fSag)")
								Divider()
								if note.bike?.rearSetup?.dualRebound == true {
									Text("HSR: \(note.rHSR)")
									Text("LSR: \(note.rLSR)")
								} else {
									Text("Reb: \(note.rRebound)")
								}
								Text("Sag %: \(note.rSag)")
							}.font(.subheadline)
							
							Spacer()
							VStack(alignment: .leading) {
								if note.bike?.frontSetup?.dualCompression == true {
									Text("HSC: \(note.fHSC)")
									Text("LSC: \(note.fLSC)")
								} else {
									Text("Comp: \(note.fCompression)")
								}
								Text("Tokens: \(note.fTokens)")
								Divider()
								if note.bike?.rearSetup?.dualCompression == true {
									Text("HSC: \(note.rHSC)")
									Text("LSC: \(note.rLSC)")
								} else {
									Text("Comp: \(note.rCompression)")
								}
								Text("Tokens: \(note.rTokens)")
							}.font(.subheadline)
						} // end HSTack Settings
					}
					.padding()
					.foregroundColor(Color("TextColor"))
					.background(Color("BackgroundColor"))
					.cornerRadius(4.0)
						// Shadow for left & Bottom
					.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
					//shadow for right & top
					//				.shadow(color: Color("ShadowColor"), radius: 5, x: 5, y: -5)
				}
			}
//			.onDelete(perform: deleteNotes)
		}
	
//	func deleteNotes(at offsets: IndexSet) {
//		for offset in offsets {
//			// find this note in our fetch request
//			let note = fetchRequest[offset]
//			// delete it from the context
//			moc.delete(note)
//		}
//		// save the context
//		try? moc.save()
//	}
	
	init(filter: Bool?){
		// need to add sort descriptors
		if filter == true {
			fetchRequest = FetchRequest<Notes>(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Notes.date, ascending: false)], predicate: NSPredicate(format: "isFavorite == TRUE"))
		} else {
			fetchRequest = FetchRequest<Notes>(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Notes.date, ascending: false)], predicate: NSPredicate(format: "isFavorite == NIL OR isFavorite == TRUE OR isFavorite == FALSE"))
		}
	}
	
	
}
