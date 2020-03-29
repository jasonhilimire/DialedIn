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
	
	@ObservedObject var frontService = FrontServiceModel()
	@ObservedObject var rearService = RearServiceModel()
	
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
	
	@State private var returnToBikeListToggle = false
	
	
	let bike: Bike
	
    var body: some View {
		VStack {
			Form{
		//MARK:- Front
				VStack(alignment: .leading){
					Text("Front Service").font(.caption).bold()
					Picker("Service Type", selection: $frontServicedIndex) {
						ForEach(0..<frontServiced.count) { index in
							Text(self.frontServiced[index]).tag(index)
						}
					}.pickerStyle(SegmentedPickerStyle())
					if frontServicedIndex == 1 {
						Text("Full Service Includes Lowers Service").italic()
						DatePicker(selection: $fFullServicedDate, in: ...Date(), displayedComponents: .date) {
							Text("Date:")
						}
						TextField("Service Note", text: $frontServicedNote)
						
					} else if frontServicedIndex == 2 {
						Text("Lowers only Serviced").italic()
						DatePicker(selection: $fLowersServicedDate, in: ...Date(), displayedComponents: .date) {
							Text("Date:")
						}
						TextField("Service Note", text: $frontServicedNote)
					}
					
				}
		//MARK:- Rear
				VStack(alignment: .leading){
					Text("Rear Service").font(.caption).bold()
					if bike.hasRearShock == false {
						Text("Hardtail")
					} else if bike.rearSetup?.isCoil == true {
						Picker("Service Type", selection: $rearServicedIndex) {
							ForEach(0..<(rearServiced.count - 1) ) { index in
								Text(self.rearServiced[index]).tag(index)
							}
						}.pickerStyle(SegmentedPickerStyle())
						
						if rearServicedIndex == 1 {
							
							DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Date")
							}
							TextField("Service Note", text: $rearServicedNote)
						}
						
						
					} else {
						Picker("Service Type", selection: $rearServicedIndex) {
							ForEach(0..<rearServiced.count) { index in
								Text(self.rearServiced[index]).tag(index)
							}
						}.pickerStyle(SegmentedPickerStyle())
						
						if rearServicedIndex == 1 {
							DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Date")
							}
							Text("Full Service Includes Air Can Service")
							TextField("Service Note", text: $rearServicedNote)
							
						} else if rearServicedIndex == 2 {
							DatePicker(selection: $rAirCanServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Date")
							}
							Text("Air Can only Serviced")
							TextField("Service Note", text: $rearServicedNote)
						}
					}
				}
				
			} // end form
				.onAppear(perform: {self.setup()})
	//			.navigationBarTitle("DialedIn", displayMode: .inline)
			
			Button(action: {
				///TODO: - change to return to  BikeListview after saving
				self.saveService()
				try? self.moc.save()
				
			}) {
				// if no toggles disable save button
				SaveButtonView()
			}
		}
		
    }
//MARK:- Functions
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		rearService.bikeName = bikeName
		rearService.getLastServicedDates()
		
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
	}
	
	func saveService() {
		print("Save button pressed")
		bikeName = self.bike.name!
		
		let newRearService = RearService(context: self.moc)
		newRearService.service?.bike = Bike(context: self.moc)
		let newBike = newRearService.service?.bike
		let newFrontService = FrontService(context: self.moc)
		
		newFrontService.service?.bike = Bike(context: self.moc)
		let newBikeFr = newFrontService.service?.bike
		newFrontService.service?.bike?.name = bikeName
		print(newFrontService.service?.bike?.name)
		
		// Setup Front Service
		
		if frontServicedIndex == 1 {
			print(bikeName)
			print(self.bikeName)
			newBikeFr?.name = bikeName
			
			
			newFrontService.fullService = self.fFullServicedDate
			newFrontService.lowersService = self.fFullServicedDate // set lower service to same as Full Service
			newFrontService.serviceNote = self.frontServicedNote
		} else if frontServicedIndex == 2 {
			newBikeFr?.name = self.bikeName
			newFrontService.lowersService = self.fLowersServicedDate
			newFrontService.serviceNote = self.frontServicedNote
		}
		
		//Setup Rear Service
		
		if rearServicedIndex == 1 {
			newBike?.name = self.bikeName
			newRearService.fullService = self.rFullServicedDate
			newRearService.airCanService = self.rFullServicedDate // set airCan Service to same date as Full Service
			newRearService.serviceNote = self.rearServicedNote
		} else if rearServicedIndex == 2 {
			newBike?.name = self.bikeName
			newRearService.airCanService = self.rAirCanServicedDate
			newRearService.airCanService = rearService.getLastFullService() // set full Service to full service as it hasnt been done
		}
		
	}
}


