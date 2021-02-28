//
//  NoteTextFavRatView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoteTextFavRatView: View {
	
	@ObservedObject var noteVM = NoteViewModel()
	
	
    var body: some View {
		HStack {
			Text("\(self.noteVM.noteDate, formatter: dateFormatter)")
				.fontWeight(.thin)
			Spacer()
			FavoritesView(favorite: self.$noteVM.noteFavorite)
			
		}.font(.headline)
		TextEditor(text: self.$noteVM.noteText)
			.font(Font.body.weight(.thin))
			.frame(height: 155)
			.textFieldStyle(PlainTextFieldStyle())
			.padding([.leading, .trailing], 4)
			.cornerRadius(8)
			.overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
			.padding([.leading, .trailing], 24)

		RatingView(rating: self.$noteVM.noteRating)
			.font(.headline)
	}
	
}



