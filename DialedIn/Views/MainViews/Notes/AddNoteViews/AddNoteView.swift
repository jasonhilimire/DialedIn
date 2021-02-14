//
//  AddNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteView: View {
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    // Get All the bikes for the PickerView
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest())
    var bikes: FetchedResults<Bike>
    
    @ObservedObject var frontSetup = NoteFrontSetupViewModel()
    @ObservedObject var rearSetup = NoteRearSetupModel()
	@ObservedObject var forkVM = ForkViewModel()
	@ObservedObject var noteVM = NoteViewModel()
	

    @State private var createdInitialBike = false
    @State private var bikeNameIndex = 0
    @State var bikeName = ""
	@State private var toggleNoteDetail = false
	@State private var saveText = "Save"

    
    var body: some View {
        NavigationView {
			VStack {
				Form{
					Section(header: Text("Ride Details")){
						if bikes.count == 1 {
							Text("\(self.bikes[bikeNameIndex].name!)")
							.fontWeight(.thin)
						} else {
							BikePickerView(bikeNameIndex: $bikeNameIndex)
						}
						DatePicker(selection: $noteVM.noteDate, in: ...Date(), displayedComponents: .date) {
							Text("Select a date:")
							.fontWeight(.thin)
						}
						Toggle(isOn: $toggleNoteDetail.animation(), label: {Text("Add Note Details").fontWeight(.thin)})
						if toggleNoteDetail == true {
							HStack {
								Text("Note:").fontWeight(.thin)

								TextEditor(text: self.$noteVM.noteText)
									.foregroundColor(.gray)
									.background(Color("TextEditBackgroundColor"))
									.cornerRadius(8)
							}
							HStack {
								RatingView(rating: $noteVM.noteRating)
								Spacer()
								Text("Favorite:").fontWeight(.thin)
								FavoritesView(favorite: self.$noteVM.noteFavorite)
							}
						}
					}
					
			// MARK: - FRONT SETUP -
					NoteFrontSetupView(front: frontSetup, noteVM: noteVM, forkVM: forkVM, note: nil)
					
			// MARK: - Rear Setup -
					NoteRearSetupView(rear: rearSetup, noteVM: noteVM, note: nil)
				} //: FORM
					.onAppear(perform: {self.setup()}) // change to onReceive??
					.navigationBarTitle("Dialed In", displayMode: .inline)
				
				Button(action: {
					self.noteVM.saveNote(bikeName: bikeName)
					
					withAnimation(.linear(duration: 0.05), {
						self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
					})
					
					hapticSuccess()
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
						self.presentationMode.wrappedValue.dismiss()
					}
				}) {
					SaveButtonView(buttonText: $saveText)
				}.buttonStyle(OrangeButtonStyle()).padding(.horizontal)
			} //: VSTACK
        }
			// Dismisses the keyboard
//		.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
    }
    
    // MARK: - FUNCTIONS -
	
    func setup() {
        bikeName = bikes[bikeNameIndex].name ?? "Unknown"
        frontSetup.bikeName = bikeName
        frontSetup.getLastFrontSettings()
		noteVM.getLastFrontNote(front: frontSetup)
		forkVM.getForkSettings(bikeName: bikeName)
		
        rearSetup.bikeName = bikeName
        rearSetup.getLastRearSettings()
		noteVM.getLastRearNote(front: rearSetup)

    }
    
}



