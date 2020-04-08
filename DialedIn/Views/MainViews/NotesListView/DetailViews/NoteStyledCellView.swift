//
//  NoteStyledCellView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/14/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct NoteStyledCellView: View {
	
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: Notes.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Notes.date, ascending: false)
	]) var notes: FetchedResults<Notes>
	
    var body: some View {
		ForEach(notes, id: \.self) { note in
			NavigationLink(destination: NotesDetailView(note: note)){
				VStack {
					HStack {
						Text(note.bike?.name ?? "Unknown Bike")
							
							.fontWeight(.thin)
						Spacer()
						Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
							.fontWeight(.ultraLight)
					}.font(.title)
					
					VStack(alignment: .leading) {
						HStack {
							VStack(alignment: .leading) {
								RatingView(rating: .constant(Int(note.rating)))
								Text(note.note ?? "")
									.font(.footnote)
									.fontWeight(.thin)
							}
							Spacer()
						}
					}
					
					HStack {
						VStack {
							HStack {
								Text("F")
								Text("\(note.fAirVolume, specifier: "%.1f")")
							} .padding([.top, .bottom, .trailing]) .font(.title)
							
							HStack {
								Text("R")
								Text("\(note.rAirSpring, specifier: "%.0f")")
							} .padding([.top, .bottom, .trailing]) .font(.title)
						}
						
						VStack(alignment: .leading) {
							if note.bike?.frontSetup?.dualRebound == true {
								Text("HSR: \(note.fHSR)")
								Text("LSR: \(note.fLSR)")
							} else {
								Text("F Reb: \(note.fRebound)")
								
							}
							Text("Sag %: \(note.fSag)")
							Divider()
							if note.bike?.rearSetup?.dualRebound == true {
								Text("HSR: \(note.rHSR)")
								Text("LSR: \(note.rLSR)")
							} else {
								Text("F Reb: \(note.rRebound)")
							}
								Text("Sag %: \(note.rSag)")
						}.font(.subheadline)
						
						
						VStack(alignment: .leading) {
							if note.bike?.frontSetup?.dualCompression == true {
								Text("HSC: \(note.fHSC)")
								Text("LSC: \(note.fLSC)")
							} else {
								Text("F Comp: \(note.fCompression)")
							}
							Text("Tokens: \(note.fTokens)")
							Divider()
							if note.bike?.rearSetup?.dualCompression == true {
								Text("HSC: \(note.rHSC)")
								Text("LSC: \(note.rLSC)")
							} else {
								Text("R Comp: \(note.rCompression)")
							}
								Text("Tokens: \(note.rTokens)")
						}.font(.subheadline)
					}
				}
				.padding()
				.foregroundColor(Color("TextColor"))
				.background(Color("BackgroundColor"))
				.cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
				.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
				.shadow(color: Color("ShadowColor"), radius: 5, x: 5, y: -5)
			}
		}
			.onDelete(perform: deleteNotes)
	}
	func deleteNotes(at offsets: IndexSet) {
		for offset in offsets {
			// find this note in our fetch request
			let note = notes[offset]
			// delete it from the context
			moc.delete(note)
		}
		// save the context
		try? moc.save()
	}
}



struct NoteStyledCellView_Previews: PreviewProvider {
    static var previews: some View {
        NoteStyledCellView()
    }
}
