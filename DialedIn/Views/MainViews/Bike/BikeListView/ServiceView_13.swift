//
//  ServiceView_13.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ServiceView_13: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	
	// Get All the bikes for the PickerView
	@FetchRequest(fetchRequest: Bike.bikesFetchRequest())
	var bikes: FetchedResults<Bike>
	
	@ObservedObject var frontService = FrontServiceModel()
	@ObservedObject var rearService = RearServiceModel()
	@ObservedObject var keyboard = KeyboardObserver()
	
	@State private var bikeNameIndex = 0
	@State private var bikeName = ""
	@State private var fFullServicedDate = Date()
	@State private var fLowersServicedDate = Date()
	@State private var frontServiced = ["None", "Full", "Lower"]
	@State private var frontServicedIndex = 0
	@State private var frontServicedNote = ""
	
	@State private var rFullServicedDate = Date()
	@State private var rAirCanServicedDate = Date()
	@State private var rearServiced = ["None", "Full", "AirCan"]
	@State private var rearServicedIndex = 0
	@State private var rearServicedNote = ""
	
	@State private var slideScreen = false
	@State private var savePressed = false
	
	@State private var saveText = "Save"
	@State private var opacity: Double = 1
	
	//	let bike: Bike
	
	var body: some View {
		NavigationView {
			VStack {
				if bikes.count == 0 {
					Text("Please Create a Bike")
						.font(.largeTitle)
						.fontWeight(.thin)
					
					
				} else {
					Form {
						if bikes.count == 1 {
							Text("\(self.bikes[bikeNameIndex].name!)")
								.fontWeight(.thin)
						} else {
							BikePickerView(bikeNameIndex: $bikeNameIndex)
						}
						//MARK:- Front
						Section(header:
									HStack {
										Image("bicycle-fork")
											.resizable()
											.frame(width: 50, height: 50)
											.scaledToFit()
										Text("Front Service")
									}
						){
							
							Picker("Service Type", selection: $frontServicedIndex) {
								ForEach(0..<frontServiced.count) { index in
									Text(self.frontServiced[index]).tag(index)
								}
							}.pickerStyle(SegmentedPickerStyle())
							if frontServicedIndex == 1 {
								HStack {
									Text("Note:").fontWeight(.thin)
									TextView(text: $frontServicedNote).cornerRadius(8)
										.onTapGesture {
											self.slideScreen = false
										}
								}
								Text("Full Service Includes Lowers Service").fontWeight(.thin).italic()
								DatePicker(selection: $fFullServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Date Serviced").fontWeight(.thin)
								}
								
							} else if frontServicedIndex == 2 {
								Text("Lowers only Serviced").fontWeight(.thin).italic()
								HStack {
									Text("Note:").fontWeight(.thin)
									TextView(text: $frontServicedNote).cornerRadius(8)
										.onTapGesture {
											self.slideScreen = false
										}
								}
								DatePicker(selection: $fLowersServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Date Serviced").fontWeight(.thin)
								}
								
							}
						}
						
						//MARK:- Rear
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
								Picker("Service Type", selection: $rearServicedIndex) {
									ForEach(0..<(rearServiced.count - 1) ) { index in
										Text(self.rearServiced[index]).tag(index)
									}
								}.pickerStyle(SegmentedPickerStyle())
								
								if rearServicedIndex == 1 {
									HStack {
										Text("Note:").fontWeight(.thin)
										TextView(text: $rearServicedNote).cornerRadius(8)
											.onTapGesture {
												self.slideScreen = true
											}
									}
									DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
										Text("Date Serviced").fontWeight(.thin)
									}
									
								}
							} else {
								Picker("Service Type", selection: $rearServicedIndex) {
									ForEach(0..<rearServiced.count) { index in
										Text(self.rearServiced[index]).tag(index)
									}
								}.pickerStyle(SegmentedPickerStyle())
								
								if rearServicedIndex == 1 {
									Text("Full Service Includes Air Can Service").fontWeight(.thin).italic()
									HStack {
										Text("Note:").fontWeight(.thin)
										TextView(text: $rearServicedNote).cornerRadius(8)
											.onTapGesture {
												self.slideScreen = true
											}
									}
									DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
										Text("Date Serviced").fontWeight(.thin)
									}
									
									
								} else if rearServicedIndex == 2 {
									Text("Air Can only Serviced").fontWeight(.thin).italic()
									HStack {
										Text("Note:").fontWeight(.thin)
										TextView(text: $rearServicedNote).cornerRadius(8)
											.onTapGesture {
												self.slideScreen = true
											}
									}
									DatePicker(selection: $rAirCanServicedDate, in: ...Date(), displayedComponents: .date) {
										Text("Date Serviced").fontWeight(.thin)
									}
									
									
								}
							}
						}
						
						
						// if no service toggles disable save button
						
					} // end form
					
					.onAppear(perform: {self.setup()})
					// Dismisses the keyboard
					.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
					.navigationBarTitle("Service")
					
					// MARK: - SAVE BUTTON
					if frontServicedIndex == 0 && rearServicedIndex == 0 {
						Text("Add a Service as needed").foregroundColor(.orange)
					} else {
						/// TODO: Encapsulate the save in a function and reset the screen & dismiss the toast
						Button(action: {
							withAnimation(.easeInOut(duration: 0.4)) {
								self.savePressed.toggle()
							}
							print("Save pressed")
							self.fetchAddService()
							try? self.moc.save()
							self.savePressed.toggle()
							
							withAnimation(.linear(duration: 0.05), {
								self.saveText = "     SAVED!!     "  // no idea why, but have to add spaces here other wise it builds the word slowly with SA...., annoying as all hell
							})
							hapticSuccess()
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
								self.setup()
							}
						}) {
							SaveButtonView(saveText: $saveText)
						}.buttonStyle(OrangeButtonStyle())
					}
				}
			}
			.padding()
			
		}
		
		
		.offset(y: slideScreen ?  -keyboard.height  :  0)
		.animation(.spring())
		
		
	}
	
	
	//MARK:- Functions
	func setup() {
		bikeName = bikes[bikeNameIndex].name ?? "Unknown"
		rearService.bikeName = bikeName
		rearService.getLastServicedDates()
		
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
		
		frontServicedIndex = 0
		rearServicedIndex = 0
		savePressed = false
		saveText = "Save"
	}
	
	
	func fetchAddService() {
		var bikes : [Bike] = []
		let fetchRequest = Bike.selectedBikeFetchRequest(filter: bikeName)
		
		do {
			bikes = try moc.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		
		let fork = bikes[0].frontSetup
		let newFrontService = FrontService(context: self.moc)
		if frontServicedIndex == 1 {
			newFrontService.fullService = self.fFullServicedDate
			newFrontService.lowersService = self.fFullServicedDate
			newFrontService.serviceNote = self.frontServicedNote
			print("full service: \(self.fFullServicedDate)")
			fork?.addToFrontService(newFrontService)
			
		} else if frontServicedIndex == 2 {
			// -- lowers only sets full service back to last full service --
			newFrontService.fullService = frontService.getFullDate(bike: bikeName)
			newFrontService.lowersService = self.fLowersServicedDate
			newFrontService.serviceNote = self.frontServicedNote
			fork?.addToFrontService(newFrontService)
		}
		
		let rear = bikes[0].rearSetup
		let newRearService = RearService(context: self.moc)
		if rearServicedIndex == 1 {
			newRearService.fullService = self.rFullServicedDate
			newRearService.airCanService = self.rFullServicedDate
			newRearService.serviceNote = self.rearServicedNote
			rear?.addToRearService(newRearService)
			
		} else if rearServicedIndex == 2 {
			// -- lowers only sets full service back to last full service --
			newRearService.fullService = rearService.getFullDate(bike: bikeName)
			newRearService.airCanService = self.rAirCanServicedDate
			newRearService.serviceNote = self.rearServicedNote
			rear?.addToRearService(newRearService)
		}
	}
}
