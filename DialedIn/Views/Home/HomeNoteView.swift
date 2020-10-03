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
	
	var fetchRequest: FetchRequest<Notes>
	
    var body: some View {
		HStack {
			FilteredNoteView(filter: true) // Seems to work if using this view- so take this view gut it and get what i need
			.padding()
			.foregroundColor(Color("TextColor"))
			
// TODO: Add A VStack with a Capsule around the text and -> that informs user that a tap will create a new note
// TODO: Possibly move the fetchRequest into the HomeTabView??  Currently doesn not refresh notes unless the app is closed
// TODO: Make a NotesView? as this is a repeat?

		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.blue)
		.cornerRadius(20)
		
	}
	
	
			
	init(){
		let request: NSFetchRequest<Notes> = Notes.fetchRequest()
		request.fetchLimit = 1
		let sort = NSSortDescriptor(keyPath: \Notes.date, ascending: false)
		request.sortDescriptors = [sort]
		//		request.predicate = what searching for here
		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
//		fetchRequest.update() // not sure why how this isnt working 'contect in environment is not connected to a persistent store manager?
	}
}
	

// Separatig each Observable object into its own View allows it to update when changing
struct NoteView: View {
	@ObservedObject var bikeModel = BikeModel()
	
	@State private var bikeName = ""
	
	var body: some View {
		HStack {
			Text("\(bikeName)")
		}.onAppear(perform: {
			self.setup()
		})
	}
	
	
	func setup() {
		let bike = bikeModel.filterLastBike()
		bikeName = bike
		print($bikeName)
	}
}
