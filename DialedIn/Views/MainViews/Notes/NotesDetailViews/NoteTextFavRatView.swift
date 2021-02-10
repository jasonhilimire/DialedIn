//
//  NoteTextFavRatView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoteTextFavRatView: View {
	
	@ObservedObject var noteModel = NoteViewModel()
	
	
    var body: some View {
		HStack {
			Text("\(self.noteModel.noteDate, formatter: dateFormatter)")
				.fontWeight(.thin)
			Spacer()
			FavoritesView(favorite: self.$noteModel.noteFavorite)
			
		}.font(.headline)
			TextView(text: $noteModel.noteText)
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
			.cornerRadius(8)
			
			RatingView(rating: self.$noteModel.noteRating)
			.font(.headline)
    }
}


