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

	@ObservedObject var noteVM = NoteViewModel()
	@ObservedObject var front = NoteFrontSetupViewModel()
	@ObservedObject var rear = NoteRearSetupModel()
	@ObservedObject var forkVM = ForkViewModel()
	@ObservedObject var rearVM = RearShockViewModel()
	
    @State private var showingDeleteAlert = false
	@State private var savePressed = false
	@State private var saveText = "Save"
	@State private var isDetailEdit = true
		
    let note: Notes
	
	init(note: Notes) {
		self.note = note
		noteVM.getNote(note: note)
		forkVM.getForkSettings(bikeName: note.bike?.name ?? "")
		rearVM.getRearSetup(bikeName: note.bike?.name ?? "")
	}
	
	// MARK - BODY -
	var body: some View {
		ScrollView {
			VStack{
				VStack {
					NoteTextFavRatView(noteVM: noteVM)
					Divider().padding(.bottom, 5)

					// MARK: - FRONT -
					
					if noteVM.isFrontEdit == true {
						NoteFrontSetupView(front: front, noteVM: noteVM, forkVM: forkVM, isDetailEdit: $isDetailEdit, note: note)
						.transition(.move(edge: .leading))
						.animation(Animation.linear(duration: 0.3))
					}
					
					if noteVM.isFrontEdit == false {
						FrontNoteDetailsView(noteVM: noteVM, note: note)
							.transition(.move(edge: .trailing))
							.animation(Animation.linear(duration: 0.3))
							.onLongPressGesture {
								self.noteVM.isFrontEdit.toggle()
							}
					}
					
					Divider().padding(.bottom, 5)
						
					// MARK: - REAR -
					
					if noteVM.isRearEdit == true {
						NoteRearSetupView(rear: rear, rearVM: rearVM, noteVM: noteVM, isDetailEdit: $isDetailEdit, note: note)
							.transition(.move(edge: .leading))
							.animation(Animation.linear(duration: 0.3))
					}
					
					if noteVM.isRearEdit == false {
						RearNoteDetailsView(noteModel: noteVM, note: note)
							.transition(.move(edge: .trailing))
							.animation(Animation.linear(duration: 0.3))
							.onLongPressGesture {
								self.noteVM.isRearEdit.toggle()
							}
					}
					
					Divider().padding(.bottom, 5)
				}
				
				.padding()
//				Spacer()
				
			} //: VSTACK
			
		} //: SCROLLVIEW
		
		// Keeps the button in a fixed position at the bottom of the view
		Button(action: {
			self.savePressed.toggle()
			withAnimation(.linear(duration: 0.05), {
				self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
			})
			self.noteVM.updateNote(self.note)
			hapticSuccess()
			// keep this as stops weird view transition to NotesF&R SetupViews
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
				self.presentationMode.wrappedValue.dismiss()
			}
		}) {
			SaveButtonView(buttonText: $saveText)
		}.buttonStyle(OrangeButtonStyle())
		.padding()
		
			
		// MARK: - MODIFIERS -
			// This keeps the keyboard from pushing the view up in iOS14
//			.ignoresSafeArea(.keyboard)

			.navigationBarTitle(Text(note.bike?.name ?? "Unknown Note"), displayMode: .inline)
		// ALERT
			.alert(isPresented: $showingDeleteAlert) {
				Alert(title: Text("Delete Note"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
					self.noteVM.deleteNote(note)
					presentationMode.wrappedValue.dismiss()
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
}



