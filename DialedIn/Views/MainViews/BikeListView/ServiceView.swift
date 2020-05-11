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
	
	@ObservedObject var frontService = FrontServiceModel()
	@ObservedObject var rearService = RearServiceModel()
	@ObservedObject var keyboard = KeyboardObserver()
	
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
	
	let bike: Bike
	
	var body: some View {
		VStack {
			Text("Shock Service").font(.largeTitle).fontWeight(.thin)
			Form {
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
						Text("Full Service Includes Lowers Service").fontWeight(.thin).italic()
						DatePicker(selection: $fFullServicedDate, in: ...Date(), displayedComponents: .date) {
							Text("Date Serviced").fontWeight(.thin)
						}
						HStack {
							Text("Note:").fontWeight(.thin)
							TextView(text: $frontServicedNote).cornerRadius(8)
						}
					} else if frontServicedIndex == 2 {
						Text("Lowers only Serviced").fontWeight(.thin).italic()
						DatePicker(selection: $fLowersServicedDate, in: ...Date(), displayedComponents: .date) {
							Text("Date Serviced").fontWeight(.thin)
						}
						HStack {
							Text("Note:").fontWeight(.thin)
							TextView(text: $frontServicedNote).cornerRadius(8)
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
					if bike.hasRearShock == false {
						Text("Hardtail").fontWeight(.thin)
					} else if bike.rearSetup?.isCoil == true {
						Picker("Service Type", selection: $rearServicedIndex) {
							ForEach(0..<(rearServiced.count - 1) ) { index in
								Text(self.rearServiced[index]).tag(index)
							}
						}.pickerStyle(SegmentedPickerStyle())
						
						if rearServicedIndex == 1 {
							
							DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Date Serviced").fontWeight(.thin)
							}
							HStack {
								Text("Note:").fontWeight(.thin)
								TextView(text: $rearServicedNote).cornerRadius(8)
							}
						}
					} else {
						Picker("Service Type", selection: $rearServicedIndex) {
							ForEach(0..<rearServiced.count) { index in
								Text(self.rearServiced[index]).tag(index)
							}
						}.pickerStyle(SegmentedPickerStyle())
						
						if rearServicedIndex == 1 {
							DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Date Serviced").fontWeight(.thin)
							}
							Text("Full Service Includes Air Can Service").fontWeight(.thin).italic()
							HStack {
								Text("Note:").fontWeight(.thin)
								TextView(text: $rearServicedNote).cornerRadius(8)
							}
							
						} else if rearServicedIndex == 2 {
							DatePicker(selection: $rAirCanServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Date Serviced").fontWeight(.thin)
							}
							Text("Air Can only Serviced").fontWeight(.thin).italic()
							HStack {
								Text("Note:").fontWeight(.thin)
								TextView(text: $rearServicedNote).cornerRadius(8)
							}
						}
					}
				}
			} // end form
				.onAppear(perform: {self.setup()})
				// Dismisses the keyboard
				.gesture(tap, including: keyboard.keyBoardShown ? .all : .none)
			
			// if no service toggles disable save button
			if frontServicedIndex == 0 && rearServicedIndex == 0 {
				Text("Add a Service as needed").foregroundColor(.orange)
			} else {
				Button(action: {
					///TODO: - change to return to  BikeListview after saving
					print("Save pressed")
					self.fetchAddService()
					try? self.moc.save()
					//dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()
				}) {
					SaveButtonView()
				}.buttonStyle(OrangeButtonStyle())
			}
		}.padding(.top)
			

	}

	
	//MARK:- Functions
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		rearService.bikeName = bikeName
		rearService.getLastServicedDates()
		
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
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



