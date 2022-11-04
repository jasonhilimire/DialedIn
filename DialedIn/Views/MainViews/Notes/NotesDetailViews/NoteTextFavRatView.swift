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
			DatePicker(selection: $noteVM.noteDate, in: ...Date(), displayedComponents: .date) {
				Text("Date:")
					.fontWeight(.thin)
			}
			Spacer()
			FavoritesView(favorite: self.$noteVM.noteFavorite)
		}
		
		TextEditor(text: self.$noteVM.noteText)
			.font(Font.body.weight(.thin))
			.frame(height: 155)
			.textFieldStyle(PlainTextFieldStyle())
			.padding([.leading, .trailing], 4)
			.cornerRadius(8)
			.overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
			.padding([.leading, .trailing], 5)
            .foregroundColor(Color("TextColor"))
            .multilineTextAlignment(.leading)
            

		RatingView(rating: self.$noteVM.noteRating)
			.font(.headline)
	}
	
}



