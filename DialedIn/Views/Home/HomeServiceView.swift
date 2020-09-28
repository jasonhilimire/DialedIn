//
//  HomeServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeServiceView: View {
	
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<Notes>
	
	// SHOW THE LAST SERVICES ADDED
	// Fetch the Bike.fork.frontservices sorted by date with a fetchlimit = 1, which will give the last record, do the same for the rear if bike names are different??? ensure show the names on the labels
	
	
	@State private var bikeName = ""
	
    var body: some View {

		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
			// when searching for note.bike? etc must now the type as it doesnt autofill
			Text(note.bike?.name ?? "Unknown Bike")
				.fontWeight(.thin)
		}
//		VStack {
//			VStack {
//				Section {
//					ForkLastServicedView(bikeName: $bikeName, fork: self.bike.frontSetup!, bike: self.bike)
//				}
//				Divider()
//				Section{
//					if self.bike.hasRearShock == false {
//						Text("HardTail")
//					} else {
//						RearShockLastServicedView(rear: self.bike.rearSetup!, bike: self.bike, bikeName: $bikeName)
//					}
//				}
//			}
			HStack {
				Text("Add Service")
					.font(.title)
					
				Image(systemName:"wrench")
					.resizable()
					.frame(width: 50, height: 50)
					.scaledToFit()
				
			}
				.foregroundColor(Color.white)
				.multilineTextAlignment(.center)
			
//		}
		
			.frame(maxWidth: .infinity, maxHeight: 150)
			.background(LinearGradient(gradient: Gradient(colors: [.green, .purple]), startPoint: .top, endPoint: .bottom))
			.cornerRadius(20)
	}
	
	init(){
		let request: NSFetchRequest<Notes> = Notes.fetchRequest()
		request.fetchLimit = 1
		let sort = NSSortDescriptor(keyPath: \Notes.date, ascending: false)
		request.sortDescriptors = [sort]
//		request.predicate = what searching for here
		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
	}
	
}
