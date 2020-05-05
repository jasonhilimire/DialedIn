//
//  FilteredAddNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/25/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredNoteView: View {
	var fetchRequest: FetchRequest<Notes>
	
    var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
			HStack {
				Text(note.bike?.name ?? "Unknown Bike")
					.fontWeight(.thin)
				Spacer()
				Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
					.fontWeight(.ultraLight)
				FavoritesView(favorite: .constant(note.isFavorite))
			}.font(.title)
		}
    }
	
	init(filter: Bool?){
		// need to add sort descriptors
		if filter == true {
			fetchRequest = FetchRequest<Notes>(entity: Notes.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavorite == TRUE"))
		} else {
			fetchRequest = FetchRequest<Notes>(entity: Notes.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavorite == NIL OR isFavorite == TRUE OR isFavorite == FALSE"))
		}
		
	}
}

//struct FilteredAddNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredAddNoteView()
//    }
//}
