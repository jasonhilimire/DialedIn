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
				Text(self.note.date != nil ? "\(self.note.date!, formatter: dateFormatter)" : "")
					.font(.largeTitle)
//				Text(self.note.bike?.name ?? "Unknown bike")
//					.font(.title)
				HStack {
					Text("Favorite Note:")
					FavoritesView(favorite: self.$isFavorite)
				}
				
				
				TextView(text: self.$noteText)
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
				RatingView(rating: self.$rating)
					.font(.title)
				Divider()
				
		   //Front
				Group {
					VStack {
						Text("Fork")
							.font(.headline)
						Text("Fork PSI: \(self.note.fAirVolume, specifier: "%.1f")")
						if self.note.bike?.frontSetup?.dualCompression == true {
							Text("High Speed Compression: \(self.note.fHSC)")
							Text("Low Speed Compression: \(self.note.fLSC)")
						} else {
							Text("Compression: \(self.note.fCompression)")
						}
						
						if self.note.bike?.frontSetup?.dualCompression == true {
							Text("High Speed Rebound: \(self.note.fHSR)")
							Text("Low Speed Rebound: \(self.note.fLSR)")
						} else {
							Text("Rebound: \(self.note.fRebound)")
						}
					}
				}
				Divider()
			//Rear
				Group {
					VStack {
						Text("Rear Shock")
							.font(.headline)
						if self.note.bike?.hasRearShock == false {
							Text("Hardtail")
						} else {
							Text("Air/Spring: \(self.note.rAirSpring, specifier: "%.0f")")
							
							if self.note.bike?.rearSetup?.dualCompression == true {
								Text("High Speed Compression: \(self.note.rHSC)")
								Text("Low Speed Compression: \(self.note.rLSC)")
							} else {
								Text("Compression: \(self.note.rCompression)")
							}
							
							if self.note.bike?.rearSetup?.dualRebound == true {
								Text("High Speed Rebound: \(self.note.rHSR)")
								Text("Low Speed Rebound: \(self.note.rLSR)")
							} else {
								Text("Rebound: \(self.note.rRebound)")
							}
						}
						
					}
					
				}
				
			}
			.padding()
			Spacer()
			Button(action: {
				self.updateNote(note: self.note)
				print("Favorite: \(self.isFavorite)")
				
				try? self.moc.save()
			}) {
				SaveButtonView()
			}.buttonStyle(OrangeButtonStyle())
			.padding()
			
		} // end form
			
	
			
		.onAppear(perform: {self.setup()})
		.onTapGesture {
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
	}
	
	func setup() {
		rating = Int(note.rating)
		noteText = note.note ?? ""
		isFavorite = note.isFavorite
	}
    

}


