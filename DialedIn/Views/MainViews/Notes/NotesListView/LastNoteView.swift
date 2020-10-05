//
//  LastNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct LastNoteView: View {
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<Notes>
	
	init(){
		let request: NSFetchRequest<Notes> = Notes.LastNoteFetchRequest()
		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
	}
	
	var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
			// REMOVE THE Navigation LINK - only need to show the note
			NavigationLink(destination: NotesDetailView(note: note)){
				NotesStyleCardView(note: note)
			}
		}
	}
}

