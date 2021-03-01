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
			VStack {
				Text("Last Note:")
					.font(.title)
					.bold()
					.customTextShadow()
				HStack {
					Text(note.bike?.name ?? "Unknown Bike")
					Spacer()
					Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
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
							Text(note.note ?? "")
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
							Text("\(note.fAirVolume, specifier: "%.1f")")
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
						
						HStack {
							Text("R")
							Text("\(note.rAirSpring, specifier: "%.0f")")
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
					}
					// TODO: the width shouldnt be fixed, but if you have 5 characters its being truncated
					.frame(width: 110, alignment: .leading)
					.customShadow()
					
					Spacer()
					
					VStack(alignment: .leading) {
						if note.bike?.frontSetup?.dualCompression == true {
							Text("HSC: \(note.fHSC)")
							Text("LSC: \(note.fLSC)")
						} else {
							Text("Comp: \(note.fCompression)")
						}
						Text("Tokens: \(note.fTokens)")
						Divider()
						if note.bike?.rearSetup?.dualCompression == true {
							Text("HSC: \(note.rHSC)")
							Text("LSC: \(note.rLSC)")
						} else {
							Text("Comp: \(note.rCompression)")
						}
						if note.bike?.rearSetup?.isCoil == false {
							Text("Tokens: \(note.rTokens)")
						} else {
							Text("")
						}
					}.font(.caption)
					
					Spacer()
					
					VStack(alignment: .leading) {
						if note.bike?.frontSetup?.dualRebound == true {
							Text("HSR: \(note.fHSR)")
							Text("LSR: \(note.fLSR)")
						} else {
							Text("Reb: \(note.fRebound)")
							
						}
						Text("Sag %: \(calcSag(sag: Double(note.fSag), travel: note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")")
						Divider()
						if note.bike?.rearSetup?.dualRebound == true {
							Text("HSR: \(note.rHSR)")
							Text("LSR: \(note.rLSR)")
						} else {
							Text("Reb: \(note.rRebound)")
						}
						Text("Sag %: \(calcSag(sag: Double(note.rSag), travel: note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")")
					}.font(.caption)
					
				} // end HSTack Settings
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
		
		


