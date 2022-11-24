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
	@ObservedObject var rearVM = RearShockViewModel()
	@ObservedObject var noteVM = NoteViewModel()
	
    @State private var createdInitialBike = false
    @State private var bikeNameIndex = 0
    @State var bikeName = ""
	@State private var toggleNoteDetail = false
	@State private var saveText = "Save"
    @State private var notePickerIndex = 0
    var notePickerText = ["RIDE DETAILS", "FRONT", "REAR"]
    
    var body: some View {
        NavigationView {
			VStack {
                    Picker("NOTE DETAILS", selection: $notePickerIndex){
                        ForEach(0..<notePickerText.count, id: \.self) { index in
                            Text(self.notePickerText[index]).tag(index)
                        }
                    }.pickerStyle(.segmented)
                        .padding(.horizontal)
                    VStack{
                        if notePickerIndex == 0 { //: SHOW DETAILS VIEW
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
                                    HStack {
                                        RatingView(rating: $noteVM.noteRating)
                                        Spacer()
                                        Text("Favorite:").fontWeight(.thin)
                                        FavoritesView(favorite: self.$noteVM.noteFavorite)
                                    }
                                    HStack(alignment: .top) {
                                        Text("Note:").fontWeight(.thin)
                                        TextEditor(text: self.$noteVM.noteText)
                                            .foregroundColor(.gray)
                                            .background(Color("TextEditBackgroundColor"))
                                            .frame(height: 300)
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .cornerRadius(8)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                        } else if notePickerIndex == 1 { //: SHOW FRONT VIEW
                            // MARK: - FRONT SETUP -
                            NoteFrontSetupView(front: frontSetup, noteVM: noteVM, forkVM: forkVM, note: nil)
                                .padding()
                            
                        } else if notePickerIndex == 2 { //: SHOW REAR VIEW
                            // MARK: - Rear Setup -
                            NoteRearSetupView(rear: rearSetup, rearVM: rearVM, noteVM: noteVM, note: nil)
                                .padding()
                        }
                        Spacer()
                    } //: FORM
                    .onAppear(perform: {self.setup()}) // change to onReceive??
                    //					.navigationBarTitle("Dialed In- New Note", displayMode: .inline)
                    // Adds a Toolbar Cancel button in the red color that will dismisses the modal
                    .toolbar{
                        SheetToolBar{
                        cancelAction: do {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        }
                        NoteToolBar(indx: $notePickerIndex)
                    }
                    
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
                    }.buttonStyle(OrangeButtonStyle()).customSaveButton()
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
		rearVM.getRearSetup(bikeName: bikeName)
    }
}



