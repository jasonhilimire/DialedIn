//
//  AddDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct NotesDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
	
	@State private var airVolume: Double = 0
	@State private var rating = 3
	@State private var noteText = ""
	@State private var isFavorite = false
	
    let note: Notes
	
    var body: some View {
		
		VStack{
			VStack {
				HStack {
				Text(self.note.date != nil ? "\(self.note.date!, formatter: dateFormatter)" : "")
					.font(.title)
					.fontWeight(.thin)
					Spacer()
				HStack {
//					Text("Favorite:")
//						.fontWeight(.thin)
					FavoritesView(favorite: self.$isFavorite)
					}
					.font(.title)
				}
				
				TextView(text: self.$noteText)
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.cornerRadius(8)
				RatingView(rating: self.$rating)
					.font(.headline)
				Divider()
				
		   //Front
				Group {
					VStack {
						VStack {
							HStack {
								Image("bicycle-fork")
									.resizable()
									.frame(width: 50, height: 50)
									.scaledToFit()
								Text("Fork Details")
									.font(.title)
									.fontWeight(.thin)
							}
						}
						Spacer()
						
						VStack {
							HStack {
								Text("Fork PSI: \(self.note.fAirVolume, specifier: "%.1f")").fontWeight(.thin)
								Text("Tokens: \(self.note.fTokens)").fontWeight(.thin)
								Text("Sag: \(self.note.fSag)").fontWeight(.thin)
							}
							
						}
						Spacer()
						
						VStack{
							if self.note.bike?.frontSetup?.dualCompression == true {
								Text("High Speed Compression: \(self.note.fHSC)").fontWeight(.thin)
								Text("Low Speed Compression: \(self.note.fLSC)").fontWeight(.thin)
							} else {
								Text("Compression: \(self.note.fCompression)").fontWeight(.thin)
							}
						}
						Spacer()
						
						VStack {
							if self.note.bike?.frontSetup?.dualCompression == true {
								Text("High Speed Rebound: \(self.note.fHSR)").fontWeight(.thin)
								Text("Low Speed Rebound: \(self.note.fLSR)").fontWeight(.thin)
							} else {
								Text("Rebound: \(self.note.fRebound)").fontWeight(.thin)
							}
						}
					}
				}
				Divider()
			//Rear
				Group {
					VStack {
						VStack {
							HStack {
								Image("shock-absorber")
									.resizable()
									.frame(width: 50, height: 50)
									.scaledToFit()
								Text("Rear Shock Details")
									.font(.title)
									.fontWeight(.thin)
							}
						}
						Spacer()
						
						VStack {
							if self.note.bike?.hasRearShock == false {
								Text("Hardtail")
									.font(.title)
									.fontWeight(.thin)
							} else {
								VStack{
									HStack{
										Text("Spring: \(self.note.rAirSpring, specifier: "%.0f")").fontWeight(.thin)
										Text("Tokens: \(self.note.rTokens)").fontWeight(.thin)
										Text("Sag: \(self.note.rSag)").fontWeight(.thin)
									}
								}
								Spacer()
								
								VStack{
									if self.note.bike?.rearSetup?.dualCompression == true {
										Text("High Speed Compression: \(self.note.rHSC)").fontWeight(.thin)
										Text("Low Speed Compression: \(self.note.rLSC)").fontWeight(.thin)
									} else {
										Text("Compression: \(self.note.rCompression)").fontWeight(.thin)
									}
								}
								Spacer()
								
								VStack {
									if self.note.bike?.rearSetup?.dualRebound == true {
										Text("High Speed Rebound: \(self.note.rHSR)").fontWeight(.thin)
										Text("Low Speed Rebound: \(self.note.rLSR)").fontWeight(.thin)
									} else {
										Text("Rebound: \(self.note.rRebound)").fontWeight(.thin)
									}
								}
							}
						}
					} 
				}
			}
			.padding()
			Spacer()
			Button(action: {
				self.updateNote(note: self.note)
				try? self.moc.save()
			}) {
				SaveButtonView()
			}.buttonStyle(OrangeButtonStyle())
			.padding()
			
		} // end form
			
		.onAppear(perform: {self.setup()})
		.onDisappear(perform: {self.updateNote(note: self.note)})
		.onTapGesture { // dismiss keyboard
			UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
		}
        .navigationBarTitle(Text(note.bike?.name ?? "Unknown Note"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Note"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteNote()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
	

    
    func deleteNote() {
        moc.delete(self.note)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
	
	func updateNote(note: Notes) {
		let updatedNote = self.noteText
		let updatedRating = self.rating
		let updatedFavorite = self.isFavorite
		moc.performAndWait {
			note.note = updatedNote
			note.rating = Int16(updatedRating)
			note.isFavorite = updatedFavorite
			try? self.moc.save()
		}
		print("Updated note: \(updatedNote)")
		presentationMode.wrappedValue.dismiss()
	}
	
	func setup() {
		rating = Int(note.rating)
		noteText = note.note ?? ""
		isFavorite = note.isFavorite
	}
    

}


