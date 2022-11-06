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

	@FetchRequest(fetchRequest: Notes.LastNoteFetchRequest())
	var notes: FetchedResults<Notes>
	
	// TODO: FIX THIS as shouldnt be hardcoding this - but has fixed issue on the ipad with multiple notes showing up
	var body: some View {
		NotesHomeStyledCardView(note: notes[0])
	}
}

