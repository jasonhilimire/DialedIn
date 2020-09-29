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
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<Notes>
	
	init(filter: String) {
		// Fetch through notes using bike.name provided and only show the last 5
		let request: NSFetchRequest<Notes> = Notes.fetchRequest()
		request.fetchLimit = 5
		request.predicate = NSPredicate(format: "%K = %@", "bike.name", filter)
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Notes.date, ascending: false)]
		fetchRequest = FetchRequest<Notes>(fetchRequest: request)
	}
	
    var body: some View {
		GeometryReader { geometry in
			ScrollView {
				ForEach(self.fetchRequest.wrappedValue, id: \.self) { note in
					NavigationLink(destination: NotesDetailView(note: note)){
						HStack{
							VStack(alignment: .leading){
								Text("\(note.date!, formatter: dateFormatter)")
									.font(.callout)
									.fontWeight(.thin)
								
								Text("\(note.wrappedNote)")
									.font(.caption)
									.fontWeight(.thin)
									.lineLimit(1)
								Divider()
							}
							.foregroundColor(Color("TextColor"))
						}
						Spacer()
						Image(systemName: "chevron.right")
						.foregroundColor(Color("ImageColor"))
						
					}
				}
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
			}
		}
    }
}

struct FilteredBikeView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredBikeNotesView(filter: "filter")
    }
}
