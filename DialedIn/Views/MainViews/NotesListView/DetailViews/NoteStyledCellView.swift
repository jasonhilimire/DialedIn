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
		NSSortDescriptor(keyPath: \Notes.date, ascending: true)
	]) var notes: FetchedResults<Notes>
	
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		return formatter
	}
	
    var body: some View {
		ForEach(notes, id: \.self) { note in
			VStack {
				HStack {
					Text(note.bike?.name ?? "Unknown Bike")
						.fontWeight(.thin)
					Spacer()
					Text(note.date != nil ? "\(note.date!, formatter: self.dateFormatter)" : "")
						.fontWeight(.ultraLight)
				}.font(.title)
				
				
				VStack(alignment: .leading) {
					HStack {
						VStack(alignment: .leading) {
							RatingView(rating: .constant(Int(note.rating)))
							Text("rating...")
								.font(.footnote)
								.fontWeight(.light)
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
						Text("HSR: \(note.fHSR)")
						Text("LSR: \(note.fLSR)")
						Text("Sag %: \(note.fSag)")
						Divider()
						Text("HSR: \(note.rHSR)")
						Text("LSR: \(note.rLSR)")
						Text("Sag %: \(note.rSag)")
					}.font(.subheadline)
					
					
					VStack(alignment: .leading) {
						Text("HSC: \(note.fHSC)")
						Text("LSC: \(note.fLSC)")
						Text("Tokens: \(note.fTokens)")
						
						Divider()
						Text("HSC: \(note.rHSC)")
						Text("LSC: \(note.rLSC)")
						Text("Tokens: \(note.rTokens)")
					}.font(.subheadline)
				}
			}
			
			.padding()
			.foregroundColor(Color.white)
			.background(Color.blue)
			.cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
			.shadow(color: Color("ShadowColor"), radius: 5, x: 12, y:15)
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
