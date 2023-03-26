//
//  NotesHomeStyledCardView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/12/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NotesHomePageStyledCardView: View {
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
                HStack{
                    Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
                        .font(.title2)
                        .bold()
                    Spacer()
                    if note.isFavorite == true {
                        HomeFavoritesView(favorite: .constant(note.isFavorite))
                    } else {
                        Text("   ")
                    }
                }//: END HSTACK
                    .customTextShadow()
                Spacer()
                Text(note.bike?.name ?? "No Bike")
                    .font(.title3)
				Spacer()
                if note.rating > 0 {
                    HomeRatingView(rating: .constant(Int(note.rating)))
                        .customShadow()
                        .padding(.bottom, 2)
                }
                Spacer()
                
				VStack(alignment: .leading) {
                    HStack {
                        Text("F:")
                        Text("\(note.fAirVolume, specifier: "%.1f")")
                        if note.bike?.frontSetup?.dualAir == true {
                            Spacer()
                            Text("F2:")
                            Text("\(note.fAirVolume2, specifier: "%.1f")")
                        }
                        Spacer()
                        if note.bike?.hasRearShock == true {
                            Text("R:")
                            Text("\(note.rAirSpring, specifier: "%.0f")")
                        }
                    }
                    .padding(.bottom, 5)
                    Text(note.note ?? "")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        
                Spacer()
				}//: END VSTACK
			} //: END VSTACK
			.padding()
			.foregroundColor(Color.white)
            .customBackgroundGradient()
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
		
		


