//
//  FilteredBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/28/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FilteredBikeView: View {
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<Notes>
	
	init(filter: String) {
		// Fetch through notes using bike.name provided 
		let predicateQuery = NSPredicate(format: "%K = %@", "bike.name", filter)
		fetchRequest = FetchRequest<Notes>(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Notes.date, ascending: false)], predicate: predicateQuery)
	}
    var body: some View {
		GeometryReader { geometry in
			ScrollView{
				VStack{
					Text("Notes")
						.font(.title)
					
					ForEach(self.fetchRequest.wrappedValue, id: \.self) { note in
						NavigationLink(destination: NotesDetailView(note: note)){
							HStack{
								VStack(alignment: .leading){
									Text("\(note.date!, formatter: dateFormatter)")
									Text("\(note.wrappedNote)")
										.lineLimit(1)
									Divider()
								}
								.font(.caption)
								.foregroundColor(Color("TextColor"))
							}
							Spacer()
							Image(systemName: "chevron.right")
							.foregroundColor(Color("ImageColor"))
							
						}
					}
					Spacer()
				}
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
			}
		}
    }
}

struct FilteredBikeView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredBikeView(filter: "filter")
    }
}
