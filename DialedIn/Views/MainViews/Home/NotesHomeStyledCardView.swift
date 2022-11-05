//
//  NotesHomeStyledCardView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/12/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NotesHomeStyledCardView: View {
	// MARK: - PROPERTIES -
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	let note: Notes
	
	@State private var showingEditScreen = false
	@State var cardAnimation = false
	
	// MARK: - BODY
	var body: some View {
		ZStack {
            VStack(alignment: .leading) {
				Text("Last Note:")
                    .font(.title3)
					.bold()
					.customTextShadow()
                Text(note.bike?.name ?? "No Bike")
				HStack {
                    Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
                    Spacer()
					if note.isFavorite == true {
						HomeFavoritesView(favorite: .constant(note.isFavorite))
					} else {
						Text("   ")
					}
				}
				Spacer()
				.customShadow()
				
				VStack(alignment: .leading) {
					HStack {
						VStack(alignment: .leading) {
							if note.rating > 0 {
								HomeRatingView(rating: .constant(Int(note.rating)))
							}
                            Spacer()
							Text(note.note ?? "")
						}
						.font(.footnote)
						Spacer()
					}
				}
			} //: END VSTACK

			.padding()
			.foregroundColor(Color.white)
			.background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red
			]) , startPoint: .top, endPoint: .bottom)))
			.cornerRadius(20)
			// Shadow for left & Bottom
			.customShadow()
			// CardAnimation
			.rotationEffect(Angle.degrees(cardAnimation ? 360 : 0))
			.animation(Animation.easeOut(duration: 1.5))
			
			
			//: CONTEXT MENU
			.contextMenu {
				VStack {
					Button(action: withAnimation() {
							{updateFavorite(note: note)}
					}) {
						HStack {
							if note.isFavorite == false {
								Text("Favorite")
								Image(systemName: "bookmark")
							} else {
								Text("Remove Favorite")
								Image(systemName: "bookmark.fill")
							}
						}
					}
					Button(action: {self.showingEditScreen.toggle()}) {
						HStack {
							Text("Edit")
							Image(systemName: "square.and.pencil")
						}
					}
					Divider()
					Button(action: {deleteNote()}) {
						HStack {
							Text("Delete")
							Image(systemName: "trash")
						}
						.foregroundColor(Color.red)
					}
				}
			}
			.sheet(isPresented: $showingEditScreen)  {
				NotesDetailView(note: note)
			}
		} //: END ZSTACK
	}
	
	// MARK: - FUNCTIONS -
	func deleteNote() {
		moc.delete(note)
		try? self.moc.save()
		hapticSuccess()
	}
	
	func updateFavorite(note: Notes) {
		self.note.isFavorite.toggle()
		self.cardAnimation.toggle()
		moc.performAndWait {
			note.isFavorite = self.note.isFavorite
			try? self.moc.save()
		}
		hapticSuccess()
	}
}
		
		


