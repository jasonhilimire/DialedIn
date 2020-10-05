//
//  HomeNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeNoteView: View {
	@Environment(\.managedObjectContext) var moc
	
    var body: some View {
		HStack {
			LastNoteView()
			
			.padding()
			.foregroundColor(Color("TextColor"))
			
// TODO: Add A VStack with a Capsule around the text and -> that informs user that a tap will create a new note
// TODO: not refreshing if a note is edited - *** seems to be occuring in normal notes view also** if adding a new notes, doesnt stay as 1 note it becomes 2
			
// TODO:

		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.blue)
		.cornerRadius(20)
	}

}
	


