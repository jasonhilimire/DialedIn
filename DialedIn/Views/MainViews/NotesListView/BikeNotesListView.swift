//
//  BikeNotesListView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 4/13/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeNotesListView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>
	
	
	let bike: Bike
	
    var body: some View {
		List{
			ForEach(bikes, id: \.self) { bike in
				Section(header: Text(bike.wrappedBikeName)) {
					ForEach(bike.notesArray, id: \.self) { note in
						NavigationLink(destination: NotesDetailView(note: note)) {
							VStack(alignment: .leading) {
								Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
								Text(note.wrappedNote)
									.font(.callout)
									.foregroundColor(.secondary)
								Text("\(note.fHSC)")
							}
						}
					}
				}
			}
		}
    }
}

