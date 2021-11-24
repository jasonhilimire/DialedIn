//
//  BikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddBikeView: View {
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var bikeVM = BikeViewModel()
	@ObservedObject var forkVM = ForkViewModel()
	@ObservedObject var rearShockVM = RearShockViewModel()
	
	@ObservedObject var frontServiceVM = FrontServiceViewModel()
	@ObservedObject var rearServiceVM = RearServiceViewModel()
	

    @State private var rearSetupIndex = 1

	@State private var saveText = "Save"
	@State private var isAdd = true
	
	@State var duplicateNameAlert = false
    
//TODO: figure out how to only allow 1 default bike
    var body: some View {
        NavigationView {
            VStack {
                Form {
					BikeDetailFormView(bikeVM: bikeVM)

// MARK: - Front Setup -
					ForkSetupFormView(forkVM: forkVM, frontServiceVM: frontServiceVM, isAdd: $isAdd)
                    
// MARK: - REAR SETUP -
					RearSetupFormView(bikeVM: bikeVM, rearShockVM: rearShockVM, rearServiceVM: rearServiceVM, rearSetupIndex: $rearSetupIndex, isAdd: $isAdd)

                } .navigationBarTitle("Bike Info", displayMode: .inline)
				.alert(isPresented: $duplicateNameAlert) {
					Alert(title: Text("Duplicate Bike Name"), message: Text("Duplicate Bike Names are not recommended - please change"), primaryButton: .destructive(Text("Clear")) {
						bikeVM.bikeName = ""
					}, secondaryButton: .cancel()
					)
				}
				.animation(.spring())
				// Adds a Toolbar Cancel button in the red color that will dismisses the modal
				.toolbar{
					SheetToolBar{
						cancelAction: do {
							self.presentationMode.wrappedValue.dismiss()
						}
					}
				}
	
                Button(action: {
					self.checkBikeNameExists()
					if duplicateNameAlert == false {
						createNewBike()
						withAnimation(.linear(duration: 0.05), {
							self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
						})
						try? self.moc.save()
						hapticSuccess()
					}
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
						// prevents the alert from being dismissed automatically
						if duplicateNameAlert == false {
							self.presentationMode.wrappedValue.dismiss()
						}
					}
                    }) {
						SaveButtonView(buttonText: $saveText)
				}.buttonStyle(OrangeButtonStyle()).customSaveButton()
                    Spacer()
            }
			.animation(.default)
        }
    }
	

	func checkBikeNameExists() {
		let filteredBikes = try! moc.fetch(Bike.bikesFetchRequest())
		for bike in filteredBikes {
			if bike.name?.lowercased() == bikeVM.bikeName!.lowercased() {
				duplicateNameAlert.toggle()
				break
			}
		}
	}
	
	func createNewBike(){
		let newFrontService = frontServiceVM.createFrontService()
		let newRearService = rearServiceVM.createRearService()
		let newFork = forkVM.createFork(newFrontService)
		let newRear = rearShockVM.createRearShock(newRearService)
		bikeVM.saveNewBike(fork: newFork, rearShock: newRear)
	}

}

