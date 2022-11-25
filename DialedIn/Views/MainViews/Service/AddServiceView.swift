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
	
	let bike: Bike
	
	var body: some View {
		NavigationView {
			VStack { //remove create bike view
                Form {
                    Section{
                        if bikes.count == 1 {
                            Text("\(bikes[bikeNameIndex].name!)")
                                .fontWeight(.thin)
                        } else if isFromBikeCard  == true {
                            Text("\(bike.wrappedBikeName)")
                                .fontWeight(.semibold)
                        } else {
                            BikePickerView(bikeNameIndex: $bikeNameIndex)
                        }
                    }
                    //MARK:- Front -
                    AddFrontServiceView(frontService: frontService)
                    
                    //MARK:- Rear -
                    AddRearServiceView(rearService: rearService, bike: bike)
                } // end form
                
                .onAppear(perform: {self.setup(isFromBikeCard: isFromBikeCard)})
                    .navigationBarTitle("Service")
                    .navigationBarTitle("Bike Details", displayMode: .inline)
                // Adds a Toolbar Cancel button in the red color that will dismisses the modal
                    .toolbar{
                        SheetToolBar{
                            cancelAction: do {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                
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
			.padding()
		}
		.animation(.spring(), value: 1)
	}

	//MARK:- Functions
	func setup(isFromBikeCard: Bool) {
        let bikeName = isFromBikeCard ? bike.wrappedBikeName : bikes[bikeNameIndex].name ?? "Unknown"
			bikeVM.getBike(for: bikeName)
			frontService.bikeName = bikeName
			rearService.bikeName = bikeName
			rearSetupVM.getRearSetup(bikeName: bikeName)
	}
	
	func addService() {
		if isFromBikeCard == true {
            bikeVM.bikeName = bike.wrappedBikeName
		}
		if frontService.frontServicedIndex != 0 {
			frontService.addFrontService(bikeName: bikeVM.bikeName ?? "" )
		}
		if rearService.rearServicedIndex != 0 {
			rearService.addRearService(bikeName: bikeVM.bikeName ?? "" )
		}
	}
	
}



