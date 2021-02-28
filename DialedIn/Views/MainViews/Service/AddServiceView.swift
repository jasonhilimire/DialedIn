//
//  AddServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/20/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddServiceView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var boolModel: BoolModel
	
	
	// Get All the bikes for the PickerView
	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>
	
	@ObservedObject var frontService = FrontServiceViewModel()
	@ObservedObject var rearService = RearServiceViewModel()
	@ObservedObject var bikeVM = BikeViewModel()
	@ObservedObject var rearSetupVM = RearShockViewModel()
	
	@State private var bikeNameIndex = 0
	
	@State private var savePressed = false
	@State private var saveText = "Save"
	@State private var opacity: Double = 1
	
	@Binding var isFromBikeCard: Bool
	
	var body: some View {
		NavigationView {
			VStack {
				if bikes.count == 0 {
					CreateBikeView()
				} else {
					Form {
						if bikes.count == 1 {
							Text("\(bikes[bikeNameIndex].name!)")
								.fontWeight(.thin)
						} else if isFromBikeCard  == true {
							Text("\(boolModel.bikeName)")
								.fontWeight(.semibold)
						} else {
							BikePickerView(bikeNameIndex: $bikeNameIndex)
						}
						//MARK:- Front -
						AddFrontServiceView(frontService: frontService)
						
						//MARK:- Rear -
						AddRearServiceView(rearService: rearService, bikeVM: bikeVM, rearSetupVM: rearSetupVM)
					} // end form
						
					.onAppear(perform: {self.setup(isFromBikeCard: isFromBikeCard)})
						.navigationBarTitle("Service")
					
				// MARK: - SAVE BUTTON -
					
					// if no service toggles disable save button
					if frontService.frontServicedIndex == 0 && rearService.rearServicedIndex == 0 {
						Text("Add a Service as needed").foregroundColor(.orange)
					} else {
						
						Button(action: {
							withAnimation(.easeInOut(duration: 0.4)) {
								self.savePressed.toggle()
							}
							
							
							self.addService()
							try? self.moc.save()
							self.savePressed.toggle()
							
							withAnimation(.linear(duration: 0.05), {
								self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
							})
							hapticSuccess()
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
								self.presentationMode.wrappedValue.dismiss()
							}
						}) {
							SaveButtonView(buttonText: $saveText)
						}.buttonStyle(OrangeButtonStyle())
					}
				}
			}
			.padding()
		}
		.animation(.spring())
	}

	
	//MARK:- Functions
	func setup(isFromBikeCard: Bool) {
		//TODO- this isnt working at all if coming from HomePage appears the VM isnt getting updated properly boolModel not working correclty??
		let bikeName = isFromBikeCard ? boolModel.bikeName : bikes[bikeNameIndex].name ?? "Unknown"
			bikeVM.getBike(for: bikeName)
			frontService.bikeName = bikeName
			rearService.bikeName = bikeName
			rearSetupVM.getRearSetup(bikeName: bikeName)
		print("Bike VM Name = \(bikeVM.bikeName)")
		
	}
	
	
	func addService() {
		if isFromBikeCard == true {
			bikeVM.bikeName = boolModel.bikeName
		}
		if frontService.frontServicedIndex != 0 {
			frontService.addFrontService(bikeName: bikeVM.bikeName ?? "" )
		}
		
		if rearService.rearServicedIndex != 0 {
			rearService.addRearService(bikeName: bikeVM.bikeName ?? "" )
		}

	}
	
}


