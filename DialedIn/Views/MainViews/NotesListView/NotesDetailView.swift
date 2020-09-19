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
	@State private var saveText = "Save"
	
    let note: Notes
	
    var body: some View {
		if #available(iOS 14.0, *) {
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
						
						//					if savePressed == true {
						//						SaveToastView()
						//							.transition(.opacity)
						//					}
						
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
											.fixedSize()
									}
								}
								Spacer()
								
								VStack {
									HStack {
										Text("Fork PSI: \(self.note.fAirVolume, specifier: "%.1f")").customNotesText()
										Text("Tokens: \(self.note.fTokens)").customNotesText()
									}
								}
								Spacer()
								VStack{
									HStack{
										Text("Sag %: \(calcSag(sag: Double(self.note.fSag), travel: self.note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")").customNotesText()
										Text("Tire PSI: \(self.note.fTirePressure, specifier: "%.1f")").customNotesText()
									}
								}
								Spacer()
								VStack{
									if self.note.bike?.frontSetup?.dualCompression == true {
										HStack {
											Text("HSC: \(self.note.fHSC)").customNotesText()
											Text("LSC: \(self.note.fLSC)").customNotesText()
										}
									} else {
										Text("Compression: \(self.note.fCompression)").customNotesText()
									}
								}
								Spacer()
								
								VStack {
									if self.note.bike?.frontSetup?.dualCompression == true {
										HStack{
											Text("HSR: \(self.note.fHSR)").customNotesText()
											Text("LSR \(self.note.fLSR)").customNotesText()
										}
									} else {
										Text("Rebound: \(self.note.fRebound)").customNotesText()
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
											.fixedSize()
									}
								}
								Spacer()
								
								VStack {
									if self.note.bike?.hasRearShock == false {
										Text("Hardtail")
											.font(.title)
											.fontWeight(.thin)
											.fixedSize()
									} else {
										VStack{
											HStack{
												Text("Spring: \(self.note.rAirSpring, specifier: "%.0f")").customNotesText()
												
												if self.note.bike?.rearSetup?.isCoil == false {
													Text("Tokens: \(self.note.rTokens)").customNotesText()
												}
											}
										}
										Spacer()
										
										VStack{
											HStack {
												Text("Sag %: \(calcSag(sag: Double(self.note.rSag), travel: self.note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")").customNotesText()
												Text("Tire PSI: \(self.note.rTirePressure, specifier: "%.1f")").customNotesText()
											}
										}
										Spacer()
										
										VStack{
											if self.note.bike?.rearSetup?.dualCompression == true {
												HStack {
													Text("HSC: \(self.note.rHSC)").customNotesText()
													Text("LSC: \(self.note.rLSC)").customNotesText()
												}
											} else {
												Text("Compression: \(self.note.rCompression)").customNotesText()
											}
										}
										Spacer()
										
										VStack {
											if self.note.bike?.rearSetup?.dualRebound == true {
												HStack{
													Text("HSR: \(self.note.rHSR)").customNotesText()
													Text("LSR: \(self.note.rLSR)").customNotesText()
												}
											} else {
												Text("Rebound: \(self.note.rRebound)").customNotesText()
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
						self.savePressed.toggle()
						withAnimation(.linear(duration: 0.05), {
							self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
						})
						
						
						self.updateNote(note: self.note)
						try? self.moc.save()
					}) {
						SaveButtonView(saveText: $saveText)
					}.buttonStyle(OrangeButtonStyle())
					.padding()
				} // end form
			}
			
			// This keeps the keyboard from pushing the view up in iOS14
			.ignoresSafeArea(.keyboard)
			
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
			//		.animation(.default) // this moves the view when Save toast appears
			.navigationBarItems(trailing: Button(action: {
				self.showingDeleteAlert = true
			}) {
				Image(systemName: "trash")
			})
				} else {
					// Fallback on earlier versions - Dont need anything here as ios13 works successfully on the keyboard slide up
				}
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
		hapticSuccess()
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



