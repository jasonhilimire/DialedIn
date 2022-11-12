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
// MARK: - PROPERTIES -
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>

	// MARK: - BODY -
	var body: some View {
		VStack {
			// dont delete this?? no idea why but it keeps from having 2 notes in the same view
			if bikes.count == 0 {
				CreateBikeView() // Create a view here
			}
				HomePageLastNoteView()
		}
	}
}
	


