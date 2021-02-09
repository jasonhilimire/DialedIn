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
	@ObservedObject var noteVM = NoteViewModel()
	@ObservedObject var front = NoteFrontSetupModel()
	@ObservedObject var rear = NoteRearSetupModel()
	
    @State private var showingDeleteAlert = false
	@State private var savePressed = false
	@State private var saveText = "Save"
	@State private var isDetailEdit = true
	
	@State private var isFrontEdit = false
	@State private var isRearEdit = false
	
	
    let note: Notes
	
	init(note: Notes) {
		self.note = note
		noteVM.getNoteModel(note: note)
	}
	
	// MARK - BODY -
	var body: some View {
		ZStack {
			VStack{
				VStack {
					NoteTextFavRatView(noteModel: noteVM)
					
					Divider().padding(.bottom, 5)

					// MARK: - FRONT -
					
					if isFrontEdit == true {
						NoteFrontSetupView(front: front, noteVM: noteVM, isDetailEdit: $isDetailEdit, note: note)
						.transition(.move(edge: .leading))
						.animation(Animation.linear(duration: 0.3))
					}
					
					if isFrontEdit == false {
						FrontNoteDetailsView(noteModel: noteVM, note: note)
							.transition(.move(edge: .trailing))
							.animation(Animation.linear(duration: 0.3))
							.onLongPressGesture {
								self.isFrontEdit.toggle()
							}
					}
					
					Divider().padding(.bottom, 5)
						
					// MARK: - REAR -
					
					if isRearEdit == true {
						NoteRearSetupView(rear: rear, noteVM: noteVM, isDetailEdit: $isDetailEdit, note: note)
							.transition(.move(edge: .leading))
							.animation(Animation.linear(duration: 0.3))
					}
					
					if isRearEdit == false {
						RearNoteDetailsView(noteModel: noteVM, note: note)
							.transition(.move(edge: .trailing))
							.animation(Animation.linear(duration: 0.3))
							.onLongPressGesture {
								self.isRearEdit.toggle()
							}
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
					self.isFrontEdit.toggle()
					self.isRearEdit.toggle()
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
				Button(action: {
					self.showingDeleteAlert = true
				}) {
					Image(systemName: "trash")
				}
			)
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
			note.note = noteVM.noteText
			note.rating = Int16(noteVM.noteRating)
			note.isFavorite = noteVM.noteFavorite
			note.fAirVolume = noteVM.fAirVolume
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



