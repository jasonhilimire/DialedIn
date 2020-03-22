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
	
	
	
	
	// if service not done need to call model and set to last service date silently
	
	let bike: Bike
	
    var body: some View {
		
		// Maybe swap this to a segmented picker
		
		 NavigationView {
			Form{
				Section {
					Text("Bike: \(self.bike.name ?? "Unknown Bike")").bold()
				}
				
				Section(header: Text("Front Service")){
					 VStack {
// Set toggle so that if full is open you cannot do lowers & includes text field telling user
						Picker("Service Type", selection: $frontServicedIndex) {
							ForEach(0..<frontServiced.count) { index in
								Text(self.frontServiced[index]).tag(index)
							}
						}.pickerStyle(SegmentedPickerStyle())
						if frontServicedIndex == 1 {
							VStack {
								DatePicker(selection: $fFullServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Select a date")
								}
								Text("Full Service Includes Lowers Service")
								TextField("Service Note", text: $frontServicedNote)
							}
							
						} else if frontServicedIndex == 2 {
							VStack {
								DatePicker(selection: $fLowersServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Select a date")
								}
								Text("Lowers only Serviced")
								TextField("Service Note", text: $frontServicedNote)
							}
						}
					}
				}
				
				Section(header: Text("Rear Service")){
					VStack {
						Picker("Service Type", selection: $rearServicedIndex) {
							ForEach(0..<rearServiced.count) { index in
								Text(self.rearServiced[index]).tag(index)
							}
						}.pickerStyle(SegmentedPickerStyle())
						
						if rearServicedIndex == 1 {
							VStack {
								DatePicker(selection: $rFullServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Select a date")
								}
								Text("Full Service Includes Lowers Service")
								TextField("Service Note", text: $rearServicedNote)
							}
							
						} else if rearServicedIndex == 2 {
							VStack {
								DatePicker(selection: $rAirCanServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Select a date")
								}
								Text("Air Can only Serviced")
								TextField("Service Note", text: $rearServicedNote)
							}
						}
						
					}
				}
				
				Button(action: {
					//dismisses the sheet
					self.presentationMode.wrappedValue.dismiss()
					self.saveService()
					
					try? self.moc.save()
				}) {
					// if no toggles disable save button
					SaveButtonView()
				}
			} // end form
				.onAppear(perform: {self.setup()})
				.navigationBarTitle("DialedIn", displayMode: .inline)
		}
        
    }
	
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		rearService.bikeName = bikeName
		rearService.getLastServiceDates()
	}
	
	func saveService() {
		print("Save button pressed")
		print("Front Index: \(frontServicedIndex)")
		print("Rear Index: \(rearServicedIndex)")
//		let newService = RearService(context: moc)
//		newService.fullService = self.rFullServiceDate
	}
}


