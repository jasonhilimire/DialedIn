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
		VStack {
			Form {
				BikeDetailFormView(bikeVM: bikeVM)
				
				// MARK: - Front Setup -
				ForkSetupFormView(forkVM: forkVM, isAdd: $isAdd)
				
				// MARK: - REAR SETUP -
				RearSetupFormView(bikeVM: bikeVM, rearShockVM: rearShockVM, rearSetupIndex: $bikeVM.rearSetupIndex, isAdd: $isAdd)

			} //: FORM
			Button(action: {
				updateBike()
				withAnimation(.linear(duration: 0.05), {
					self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
				})
				
				hapticSuccess()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
					self.presentationMode.wrappedValue.dismiss()
				}
			}) {
				SaveButtonView(buttonText: $saveText)
			}.buttonStyle(OrangeButtonStyle()).customSaveButton()
			
		}

	}
	
	//MARK: - FUNCTIONS -
	
	func updateBike() {
		boolModel.bikeName = bikeVM.bikeName ?? "" // republish the BoolModel Name so EditBikeDetail doesnt crash
		let updatedFork = forkVM.updateFork(fork: bike.frontSetup!)
		let updatedRear = rearShockVM.updateRearShock(rear: bike.rearSetup!)
		bikeVM.updateBike(bike: bike, fork: updatedFork, rearShock: updatedRear)
		}
	

}
