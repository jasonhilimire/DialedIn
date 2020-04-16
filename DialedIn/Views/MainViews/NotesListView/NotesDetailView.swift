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
	
	
	/// TODO: List out all variables that need to be edited
	/// - then use setup() to set the variables
	/// - - Create the form and ability to setup all the details
	/// - - - Save the form if there are any changes
	/// - - - - Add a Save button
	

    let note: Notes

	
	
    var body: some View {
		Form{
			VStack {
				Text(self.note.date != nil ? "\(self.note.date!, formatter: dateFormatter)" : "")
				Text(self.note.bike?.name ?? "Unknown bike")
					.font(.title)
				TextField(self.note.note ?? "No note", text: self.$noteText)

					.padding()
					.border(Color.orange, width: 1.0)
				RatingView(rating: self.$rating)
					.font(.subheadline)
				Divider()
				
		   //Front
				Group {
					VStack {
						HStack{
							Text("PSI: \(self.airVolume, specifier: "%.1f")")
						}
						Text("Air Spring: \(self.note.fAirVolume, specifier: "%.1f")")
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
			Button(action: {
				//dismisses the sheet
				self.presentationMode.wrappedValue.dismiss()
				self.updateNote(note: self.note)
				
				try? self.moc.save()
			}) {
				SaveButtonView()
			}
			
		} // end form
			
		
			
		.onAppear(perform: {self.setup()})
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
		moc.performAndWait {
			note.note = updatedNote
			note.rating = Int16(updatedRating)
			try? self.moc.save()
		}
		// https://www.youtube.com/watch?v=Y8bgTSYsDvg
	}
	
	func setup() {
		rating = Int(note.rating)
		airVolume = self.note.fAirVolume
		noteText = note.note ?? ""
	}
    

}


