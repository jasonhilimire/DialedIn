//
//  LastNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct HomePageLastNoteView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(fetchRequest: Notes.LastNoteFetchRequest())
    var notes: FetchedResults<Notes>
    
    // TODO: FIX THIS as shouldnt be hardcoding this - as wont work when no notes
    var body: some View {
        NotesHomePageStyledCardView(note: notes[0])
    }
}

