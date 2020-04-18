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
//				.navigationBarTitle("Service", displayMode: .inline)
			
			
			
			if frontServicedIndex == 0 && rearServicedIndex == 0 {
				Text("Add a Service as needed")
			} else {
				Button(action: {
///TODO: - change to return to  BikeListview after saving

					self.fetchAddService()
					try? self.moc.save()
					//dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()

					
				}) {
					// if no toggles disable save button
					SaveButtonView()
				}
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
		newFrontService.service = Fork(context: self.moc)
		
		let newBike = newRearService.service?.bike
			
			*/
		
		
		// - Bike Creation
		
//		newBike?.name = self.bikeName
		
		// Setup Front Service
		
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
			newRearService.service?.bike = newBike
			newRearService.service?.bike?.hasRearShock = true
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
*/
	}
	
}


