//
//  FilteredBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/28/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredBikeNotesView: View {
	// MARK: - PROPERTIES -
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<Notes>
	
	init(filter: String) {
		let request: NSFetchRequest<Notes> = Notes.Last5NotesFetchRequest(filter: filter)
		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
	}
	
	// MARK: - BODY -
    var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack {
					Text("Last 5 Notes")
						.font(.title2)
						.fontWeight(.bold)
						.customTextShadow()
					ForEach(self.fetchRequest.wrappedValue, id: \.self) { note in
						NavigationLink(destination: NotesDetailView(note: note)){
							HStack{
								VStack(alignment: .leading){
									Text("\(note.date!, formatter: dateFormatter)")
										.font(.callout)
										.fontWeight(.light)
									
									Text("\(note.wrappedNote)")
										.font(.caption)
										.fontWeight(.light)
										.lineLimit(1)
									Divider()
								}
							}
							Spacer()
							Image(systemName: "chevron.right")
							.foregroundColor(Color("ImageColor"))
						}
					}
				}
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
			}
		}

    }
}
