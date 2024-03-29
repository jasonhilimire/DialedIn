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
    @ObservedObject var rearSetup = NoteRearSetupViewModel()
	@ObservedObject var forkVM = ForkViewModel()
	@ObservedObject var rearVM = RearShockViewModel()
	@ObservedObject var noteVM = NoteViewModel()
	
    @State private var createdInitialBike = false
    @State private var bikeNameIndex = 0
    @State var bikeName = ""
	@State private var toggleNoteDetail = false
	@State private var saveText = "Save"
    @State private var notePickerIndex = 0
    @State private var tappedPicker = false
    @Binding var isFromBikeCard: Bool
    
    let bike: Bike
    var notePickerText = ["RIDE DETAILS", "FRONT", "REAR"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $notePickerIndex){
                    ForEach(0..<notePickerText.count, id: \.self) { index in
                        Text(self.notePickerText[index]).tag(index)
                    }
                }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .onChange(of: notePickerIndex) { _ in
                        if !tappedPicker {
                            self.setup(isFromBikeCard: isFromBikeCard)
                            tappedPicker = true
                        }
                }
                    
                
                ScrollView {
                    VStack{
                        if notePickerIndex == 0 { //: SHOW DETAILS VIEW
                            if bikes.count == 1 {
                                Text("\(self.bikes[bikeNameIndex].name!)")
                                    .fontWeight(.thin)
                            } else if isFromBikeCard  == true {
                                Text("\(bike.wrappedBikeName)")
                                    .fontWeight(.semibold)
                            } else {
                                HStack {
                                    Text("Bike: ")
                                    BikePickerView(bikeNameIndex: $bikeNameIndex)
                                        .onChange(of: bikeNameIndex) { _ in
                                            self.setup(isFromBikeCard: isFromBikeCard)
                                    }
                                }
                            }
                            
                            DatePicker(selection: $noteVM.noteDate, in: ...Date(), displayedComponents: .date) {
                                Text("Select a date:")
                                    .fontWeight(.thin)
                            }
                                .padding(.bottom)
                            HStack {
                                RatingView(rating: $noteVM.noteRating)
                                Spacer()
                                Text("Favorite:").fontWeight(.thin)
                                FavoritesView(favorite: self.$noteVM.noteFavorite)
                            }
                                .padding(.bottom)
                            
                            VStack {
                                HStack(alignment: .top) {
                                    Text("Note:").fontWeight(.thin)
                                    Spacer()
                                }
                                TextEditor(text: self.$noteVM.noteText)
                                    .frame(height: 250)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .cornerRadius(8)
                                    .multilineTextAlignment(.leading)
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            } //: VSTACK
                        } else if notePickerIndex == 1 { //: SHOW FRONT VIEW
                            // MARK: - FRONT SETUP -
                            NoteFrontSetupView(front: frontSetup, noteVM: noteVM, forkVM: forkVM, note: nil)
                                .padding()
                        } else if notePickerIndex == 2 { //: SHOW REAR VIEW
                            // MARK: - Rear Setup -
                            NoteRearSetupView(rear: rearSetup, rearVM: rearVM, noteVM: noteVM, note: nil)
                                .padding()
                        }
                    } //: VSTACK
                
                // Adds a Toolbar Cancel button in the red color that will dismisses the modal
                .toolbar{
                    SheetToolBar{ cancelAction: do {
                        self.presentationMode.wrappedValue.dismiss()}
                    }
                    NoteToolBar(indx: $notePickerIndex)
                }
                .padding()
            } //: SCROLLVIEW
        }
    }
            .onAppear(perform: {self.setup(isFromBikeCard: isFromBikeCard)}) // change to onReceive??
        Button(action: {
            self.noteVM.saveNote(bikeName: self.bikeName)
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
			// Dismisses the keyboard
//		.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
    }
    // MARK: - FUNCTIONS -
	
    func setup(isFromBikeCard: Bool) { // SETS UP PREVIOUS SETTINGS FOR F/R
        bikeName = isFromBikeCard ? bike.wrappedBikeName : bikes[bikeNameIndex].name ?? "Unknown"
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
