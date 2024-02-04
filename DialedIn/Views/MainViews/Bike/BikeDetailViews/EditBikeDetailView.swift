//
//  EditBikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 6/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct EditBikeDetailView: View {
	//MARK: - PROPERTIES -

	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@EnvironmentObject var boolModel: BoolModel
	
	@ObservedObject var forkVM = ForkViewModel()
	@ObservedObject var rearShockVM = RearShockViewModel()
	@ObservedObject var bikeVM = BikeViewModel()
	
	@State private var saveText = "Save"
	@State private var isAdd = false
	@State var duplicateNameAlert = false
    @State private var bikePickerIndex = 0
    var bikePickerText = ["DETAILS", "FRONT", "REAR"]

	let bike: Bike

	init(bike: Bike) {
		self.bike = bike
		let bikeName = bike.name
		bikeVM.getBike(for: bikeName!)
		bikeVM.getSetupIndex(bike: bike)
		forkVM.getForkSettings(bikeName: bikeName!)
		rearShockVM.getRearSetup(bikeName: bikeName!)
	}
	
	//TODO: figure out how to only allow 1 default bike
	//MARK: - BODY -
	var body: some View {
		NavigationView{
			VStack {
                Picker("NOTE DETAILS", selection: $bikePickerIndex){
                    ForEach(0..<bikePickerText.count, id: \.self) { index in
                        Text(self.bikePickerText[index]).tag(index)
                    }
                }.pickerStyle(.segmented)
                .padding()
				Form {
                    if bikePickerIndex == 0 {
                        BikeDetailFormView(bikeVM: bikeVM)
                    } else if bikePickerIndex == 1 {
                        // MARK: - Front Setup -
                        ForkSetupFormView(forkVM: forkVM, isAdd: $isAdd)
                    } else if bikePickerIndex == 2 {
                        // MARK: - REAR SETUP -
                        RearSetupFormView(bikeVM: bikeVM, rearShockVM: rearShockVM, rearSetupIndex: $bikeVM.rearSetupIndex, isAdd: $isAdd)
                    }
				} //: FORM
				.alert(isPresented: $duplicateNameAlert) {
					Alert(title: Text("Duplicate Bike Name"), message: Text("Duplicate Bike Names are not recommended - please change"), primaryButton: .destructive(Text("Clear")) {
						bikeVM.bikeName = ""
					}, secondaryButton: .cancel()
					)
				}
                .animation(.spring(), value: 1)
				
				Button(action: {
					//TODO: Removed duplicate check on edit as it wasnt allowing any edits - this is likely because we are resaving boolModel.bikeName as bikeVM.bikeName
	//				self.checkBikeNameExists()
					if duplicateNameAlert == false {
						updateBike()
					
						withAnimation(.linear(duration: 0.05), {
							self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
						})
						
						hapticSuccess()
					}
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						// prevents the alert from being dismissed automatically
						if duplicateNameAlert == false {
							self.presentationMode.wrappedValue.dismiss()
						}
					}
				}) {
					SaveButtonView(buttonText: $saveText)
				}.buttonStyle(OrangeButtonStyle()).customSaveButton()
				
			}
			.navigationBarTitle("Edit Bike Details", displayMode: .inline)
			// Adds a Toolbar Cancel button in the red color that will dismisses the modal
			.toolbar{
				SheetToolBar{
					cancelAction: do {
						self.presentationMode.wrappedValue.dismiss()
					}
				}
			}
		}
	}
	
	//MARK: - FUNCTIONS -
	
	func updateBike() {
		boolModel.bikeName = bikeVM.bikeName ?? "" // republish the BoolModel Name so EditBikeDetail doesnt crash
		let updatedFork = forkVM.updateFork(fork: bike.frontSetup!)
		let updatedRear = rearShockVM.updateRearShock(rear: bike.rearSetup!)
		bikeVM.updateBike(bike: bike, fork: updatedFork, rearShock: updatedRear)
		}
	
	func checkBikeNameExists() {
		let filteredBikes = try! moc.fetch(Bike.bikesFetchRequest())
		for bike in filteredBikes {
			if  bikeVM.bikeName!.lowercased() == bike.name?.lowercased(){
				duplicateNameAlert.toggle()
				break
			}
		}
	}
	

}
