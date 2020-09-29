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
		ForEach(fetchRequest.wrappedValue, id: \.self) { note in
			NoteView(note: note)
		/*
			VStack {
				HStack {
					Text(note.bike?.name ?? "Unknown Bike")
						.fontWeight(.thin)
					Spacer()
					Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
						.fontWeight(.thin)
					if note.isFavorite == true {
						FavoritesView(favorite: .constant(note.isFavorite))
					} else {
						Text("   ")
					}
				}
//					Spacer()
				
				VStack(alignment: .leading) {
					HStack {
						VStack(alignment: .leading) {
							if note.rating > 0 {
								RatingView(rating: .constant(Int(note.rating)))
							}
//							Text(note.note ?? "")
//								.fontWeight(.thin)
					// Use an observed object in a new view for items that will change/ can be changed
							NoteView(note: note)
						}
						.font(.footnote)
						Spacer()
					}
				}
				
				Divider()
				
				HStack {
					VStack {
						HStack {
							Text("F")
								.fontWeight(.thin)
							Text("\(note.fAirVolume, specifier: "%.1f")")
								.fontWeight(.thin)
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
						
						
						HStack {
							Text("R")
								.fontWeight(.thin)
							Text("\(note.rAirSpring, specifier: "%.0f")")
								.fontWeight(.thin)
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
					}
					// TODO: the width shouldnt be fixed, but if you have 5 characters its being truncated
					.frame(width: 110, alignment: .leading)
					
//						Spacer()
					VStack(alignment: .leading) {
						if note.bike?.frontSetup?.dualRebound == true {
							Text("HSR: \(note.fHSR)").fontWeight(.thin)
							Text("LSR: \(note.fLSR)").fontWeight(.thin)
						} else {
							Text("Reb: \(note.fRebound)").fontWeight(.thin)
							
						}
						Text("Sag %: \(calcSag(sag: Double(note.fSag), travel: note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")").fontWeight(.thin)
						Divider()
						if note.bike?.rearSetup?.dualRebound == true {
							Text("HSR: \(note.rHSR)").fontWeight(.thin)
							Text("LSR: \(note.rLSR)").fontWeight(.thin)
						} else {
							Text("Reb: \(note.rRebound)").fontWeight(.thin)
						}
						Text("Sag %: \(calcSag(sag: Double(note.rSag), travel: note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")").fontWeight(.thin)
					}.font(.caption)
					
//						Spacer()
					VStack(alignment: .leading) {
						if note.bike?.frontSetup?.dualCompression == true {
							Text("HSC: \(note.fHSC)").fontWeight(.thin)
							Text("LSC: \(note.fLSC)").fontWeight(.thin)
						} else {
							Text("Comp: \(note.fCompression)").fontWeight(.thin)
						}
						Text("Tokens: \(note.fTokens)").fontWeight(.thin)
						Divider()
						if note.bike?.rearSetup?.dualCompression == true {
							Text("HSC: \(note.rHSC)").fontWeight(.thin)
							Text("LSC: \(note.rLSC)").fontWeight(.thin)
						} else {
							Text("Comp: \(note.rCompression)").fontWeight(.thin)
						}
						if note.bike?.rearSetup?.isCoil == false {
							Text("Tokens: \(note.rTokens)").fontWeight(.thin)
						} else {
							Text("").fontWeight(.thin)
						}
					}.font(.caption)
				} // end HSTack Settings
			}
			*/
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
	@ObservedObject var note: Notes
	
	var body: some View {
		Text(note.note ?? "")
	}
}
