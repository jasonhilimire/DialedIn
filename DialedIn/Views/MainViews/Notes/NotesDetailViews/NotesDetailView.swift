//
//  NotesDetailView.swift
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
	@ObservedObject var noteModel = EditNoteViewModel()
	@ObservedObject var front = NoteFrontSetupModel()
	
    @State private var showingDeleteAlert = false
	@State private var showingEditDetail = false
	@State private var savePressed = false
	@State private var saveText = "Save"
	@State private var isDetailEdit = true
	
	@State private var isFrontEdit = false
	
	
    let note: Notes
	
	init(note: Notes) {
		self.note = note
		noteModel.getNoteModel(note: note)
	}
	
	// MARK - BODY -
	var body: some View {
		ZStack {
			VStack{
				VStack {
					
						NoteTextFavRatView(noteModel: noteModel)
							
					
					Divider().padding(.bottom, 5)
						// Save button needs to toggle isFrontEdit

					// MARK: - FRONT -
					
					if isFrontEdit == true {
						HStack{
							Text("PSI: \(noteModel.fAirVolume, specifier: "%.1f")").fontWeight(.thin)
							Slider(value: $noteModel.fAirVolume, in: 45...120, step: 1.0)

						}
						.transition(.move(edge: .leading))
						.animation(Animation.linear(duration: 0.3))
					}
					
					
					if isFrontEdit == false {
						FrontNoteDetailsView(noteModel: noteModel, note: note)
							.transition(.move(edge: .trailing))
							.animation(Animation.linear(duration: 0.3))
							.onLongPressGesture {
								self.isFrontEdit.toggle()
							}
					}
					
					Divider().padding(.bottom, 5)
						

					// MARK: - REAR -
					
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
					self.isFrontEdit.toggle()
				}) {
					SaveButtonView(buttonText: $saveText)
				}.buttonStyle(OrangeButtonStyle())
				.padding()
			} //: FORM
		}
			
		// MARK: - MODIFIERS -
			// This keeps the keyboard from pushing the view up in iOS14
			.ignoresSafeArea(.keyboard)
			// Dismisses the keyboard
			.onTapGesture { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
			.navigationBarTitle(Text(note.bike?.name ?? "Unknown Note"), displayMode: .inline)
		// ALERT
			.alert(isPresented: $showingDeleteAlert) {
				Alert(title: Text("Delete Note"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
					self.deleteNote()
				}, secondaryButton: .cancel())
			}
			.navigationBarItems(trailing:
				HStack {
					Button(action: {
						showingEditDetail.toggle()
						
					}) {
						Image(systemName: "square.and.pencil")
							.padding(.horizontal, 20)
					}
					Spacer(minLength: 5)
					Button(action: {
						self.showingDeleteAlert = true
					}) {
						Image(systemName: "trash")
					}
			})
			.sheet(isPresented: $showingEditDetail)  {
				EditNoteDetailView(note: note).environment(\.managedObjectContext, self.moc)
			}
    }
	

    // MARK: - FUNCTIONS -
    func deleteNote() {
        moc.delete(self.note)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
	
	// TODO: Move this to the view Model
	func updateNote(note: Notes) {
		moc.performAndWait {
			note.note = noteModel.noteText
			note.rating = Int16(noteModel.noteRating)
			note.isFavorite = noteModel.noteFavorite
			note.fAirVolume = noteModel.fAirVolume
			if self.moc.hasChanges {
				try? self.moc.save()
			}
		}
		hapticSuccess()
		// this pauses the view transition
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
			self.presentationMode.wrappedValue.dismiss()
			
		}
	}
}



