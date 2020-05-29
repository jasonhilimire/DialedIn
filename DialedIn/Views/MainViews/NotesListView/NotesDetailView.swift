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
	@ObservedObject var keyboard = KeyboardObserver()
	
    @State private var showingDeleteAlert = false
	
	@State private var airVolume: Double = 0
	@State private var rating = 3
	@State private var noteText = ""
	@State private var isFavorite = false
	
	@State private var savePressed = false
	
    let note: Notes
	
    var body: some View {
		ZStack {
			VStack{
				VStack {
					HStack {
					Text(self.note.date != nil ? "\(self.note.date!, formatter: dateFormatter)" : "")
						.fontWeight(.thin)
						Spacer()
						FavoritesView(favorite: self.$isFavorite)
						
					}.font(.headline)
					
					TextView(text: self.$noteText)
						.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
						.cornerRadius(8)
					RatingView(rating: self.$rating)
						.font(.headline)
					Divider()
					
					if savePressed == true {
						SaveToastView()
							.transition(.opacity)
					}
					
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
										.font(.headline)
										.fontWeight(.thin)
								}
							}
							Spacer()
							
							VStack {
								HStack {
									Text("Fork PSI: \(self.note.fAirVolume, specifier: "%.1f")").fontWeight(.thin)
									Text("Tokens: \(self.note.fTokens)").fontWeight(.thin)
								}
							}
							Spacer()
							VStack{
								HStack{
									Text("Sag %: \(calcSag(sag: Double(self.note.fSag), travel: self.note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")").fontWeight(.thin)
									Text("Tire PSI: \(self.note.fTirePressure, specifier: "%.1f")").fontWeight(.thin)
								}
							}
							Spacer()
							VStack{
								if self.note.bike?.frontSetup?.dualCompression == true {
									HStack {
										Text("HSC: \(self.note.fHSC)").fontWeight(.thin)
										Text("LSC: \(self.note.fLSC)").fontWeight(.thin)
									}
								} else {
									Text("Compression: \(self.note.fCompression)").fontWeight(.thin)
								}
							}
							Spacer()
							
							VStack {
								if self.note.bike?.frontSetup?.dualCompression == true {
									HStack{
										Text("HSR: \(self.note.fHSR)").fontWeight(.thin)
										Text("LSR \(self.note.fLSR)").fontWeight(.thin)
									}
								} else {
									Text("Rebound: \(self.note.fRebound)").fontWeight(.thin)
								}
							}
						}
						.font(.subheadline)
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
										.font(.headline)
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
										}
									}
									Spacer()
									
									VStack{
										HStack {
											Text("Sag %: \(calcSag(sag: Double(self.note.rSag), travel: self.note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")").fontWeight(.thin)
											Text("Tire PSI: \(self.note.rTirePressure, specifier: "%.1f")").fontWeight(.thin)
										}
									}
									Spacer()
									
									VStack{
										if self.note.bike?.rearSetup?.dualCompression == true {
											HStack {
												Text("HSC: \(self.note.rHSC)").fontWeight(.thin)
												Text("LSC: \(self.note.rLSC)").fontWeight(.thin)
											}
										} else {
											Text("Compression: \(self.note.rCompression)").fontWeight(.thin)
										}
									}
									Spacer()
									
									VStack {
										if self.note.bike?.rearSetup?.dualRebound == true {
											HStack{
												Text("HSR: \(self.note.rHSR)").fontWeight(.thin)
												Text("LSR: \(self.note.rLSR)").fontWeight(.thin)
											}
										} else {
											Text("Rebound: \(self.note.rRebound)").fontWeight(.thin)
										}
									}
								}
							}
						}
						.font(.subheadline)
					}
				}
					
			.padding()
			Spacer()
			Button(action: {
				withAnimation(.easeInOut(duration: 0.4)) {
					self.savePressed.toggle()
				}
				
				
				self.updateNote(note: self.note)
				try? self.moc.save()
			}) {
				SaveButtonView()
			}.buttonStyle(OrangeButtonStyle())
			.padding()
			
			} // end form
			
			
		}
		
		.onAppear(perform: {self.setup()})
			// Dismisses the keyboard
		.onTapGesture { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
        .navigationBarTitle(Text(note.bike?.name ?? "Unknown Note"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Note"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteNote()
                }, secondaryButton: .cancel()
            )
        }
		.animation(.default) // this moves the view when Save toast appears
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
		// this pauses the view transition
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
			self.presentationMode.wrappedValue.dismiss()
			
		}
	}
	
	func setup() {
		rating = Int(note.rating)
		noteText = note.note ?? ""
		isFavorite = note.isFavorite
	}
    

}


