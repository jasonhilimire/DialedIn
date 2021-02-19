//
//  ServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/20/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ServiceView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var boolModel: BoolModel
	
	
	// Get All the bikes for the PickerView
	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>
	
	@ObservedObject var frontService = FrontServiceViewModel()
	@ObservedObject var rearService = RearServiceViewModel()
	
	@State private var bikeNameIndex = 0
	@State private var bikeName = ""
	
	@State private var savePressed = false
	@State private var saveText = "Save"
	@State private var opacity: Double = 1
	
	var isFromBikeCard: Binding<Bool>?
//	let bike: Bike?

	
	var body: some View {
		NavigationView {
			VStack {
				if bikes.count == 0 {
					CreateBikeView()
				} else {
					Form {
						if bikes.count == 1 {
							Text("\(self.bikes[bikeNameIndex].name!)")
								.fontWeight(.thin)
						} else if (isFromBikeCard != nil) == true {
							Text("\(boolModel.bikeName)")
								.fontWeight(.semibold)
						} else {
							BikePickerView(bikeNameIndex: $bikeNameIndex)
						}
						//MARK:- Front -
						Section(header:
							HStack {
								Image("bicycle-fork")
									.resizable()
									.frame(width: 50, height: 50)
									.scaledToFit()
								Text("Front Service")
								}
							){
							
							Picker("Service Type", selection: $frontService.frontServicedIndex) {
								ForEach(0..<frontService.frontServiced.count) { index in
									Text(self.frontService.frontServiced[index]).tag(index)
								}
							}.pickerStyle(SegmentedPickerStyle())
							if frontService.frontServicedIndex == 1 {
								Text("Full Service Includes Lowers Service").fontWeight(.thin).italic()
								HStack {
									Text("Note:").fontWeight(.thin)

									CustomTextField(text: $frontService.serviceNote , placeholder: "")
								}
								
								DatePicker(selection: $frontService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
									Text("Date Serviced").fontWeight(.thin)
								}
								
							} else if frontService.frontServicedIndex == 2 {
								Text("Lowers only Serviced").fontWeight(.thin).italic()
								HStack {
									Text("Note:").fontWeight(.thin)
									CustomTextField(text: $frontService.serviceNote, placeholder: "")
								}
								DatePicker(selection: $frontService.lowersServiceDate, in: ...Date(), displayedComponents: .date) {
									Text("Date Serviced").fontWeight(.thin)
								}
								
							}
						}
						
						//MARK:- Rear -
						Section(header:
							HStack {
								Image("shock-absorber")
									.resizable()
									.frame(width: 50, height: 50)
									.scaledToFit()
								Text("Rear Service")
							}
						){
							if self.bikes[bikeNameIndex].hasRearShock == false {
								Text("Hardtail").fontWeight(.thin)
							} else if self.bikes[bikeNameIndex].rearSetup?.isCoil == true {
								Picker("Service Type", selection: $rearService.rearServicedIndex) {
									ForEach(0..<(rearService.rearServiced.count - 1) ) { index in
										Text(self.rearService.rearServiced[index]).tag(index)
									}
								}.pickerStyle(SegmentedPickerStyle())
								
								if rearService.rearServicedIndex == 1 {
									HStack {
										Text("Note:").fontWeight(.thin)

										CustomTextField(text: $rearService.serviceNote, placeholder: "")
									}
									DatePicker(selection: $rearService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
										Text("Date Serviced").fontWeight(.thin)
									}
									
								}
							} else {
								Picker("Service Type", selection: $rearService.rearServicedIndex) {
									ForEach(0..<rearService.rearServiced.count) { index in
										Text(self.rearService.rearServiced[index]).tag(index)
									}
								}.pickerStyle(SegmentedPickerStyle())
								
								if rearService.rearServicedIndex == 1 {
									Text("Full Service Includes Air Can Service").fontWeight(.thin).italic()
									HStack {
										Text("Note:").fontWeight(.thin)
										CustomTextField(text: $rearService.serviceNote, placeholder: "")
									}
									DatePicker(selection: $rearService.fullServiceDate, in: ...Date(), displayedComponents: .date) {
										Text("Date Serviced").fontWeight(.thin)
									}
									
								} else if rearService.rearServicedIndex == 2 {
									Text("Air Can only Serviced").fontWeight(.thin).italic()
									HStack {
										Text("Note:").fontWeight(.thin)
										CustomTextField(text: $rearService.serviceNote, placeholder: "")
									}
									DatePicker(selection: $rearService.airCanServicedDate, in: ...Date(), displayedComponents: .date) {
										Text("Date Serviced").fontWeight(.thin)
									}
								}
							}
						}
					} // end form
						
						.onAppear(perform: {self.setup()})
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
								self.setup()
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
	func setup() {
		bikeName = bikes[bikeNameIndex].name ?? "Unknown"
		frontService.bikeName = bikeName
		rearService.bikeName = bikeName
		savePressed = false
		saveText = "Save"
	}
	
	
	func addService() {
		if (isFromBikeCard != nil) {
			bikeName = boolModel.bikeName
			print("Service view bike name is \(bikeName)")
		}
		
		if frontService.frontServicedIndex != 0 {
			frontService.addFrontService(bikeName: bikeName)
		}
		
		if rearService.rearServicedIndex != 0 {
			rearService.addRearService(bikeName: bikeName)
		}

	}
	
}



