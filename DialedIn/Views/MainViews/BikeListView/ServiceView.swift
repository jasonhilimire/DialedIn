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
	@State private var fullForkServiceToggle = false
	@State private var fFullServicedDate = Date()
	@State private var lowersForkServiceToggle = false
	@State private var fLowersServicedDate = Date()
	
	
	@State private var fullRearServiceToggle = false
	@State private var rFullServiceDate = Date()
	@State private var airCanServiceToggle = false
	@State private var rAirCanServiceDate = Date()
	
	
	
	// if service not done need to call model and set to last service date silently
	
	let bike: Bike
	
    var body: some View {
		NavigationView {
			Form{
				Section {
					Text("Bike: \(self.bike.name ?? "Unknown Bike")").bold()
				}
				
				Section(header: Text("Front Service")){
					VStack {
// Set toggle so that if full is open you cannot do lowers & includes text field telling user
						Toggle(isOn: $fullForkServiceToggle.animation(), label: {Text("Full Service")})
						if fullForkServiceToggle  {
							VStack() {
								DatePicker(selection: $fFullServicedDate, in: ...Date(), displayedComponents: .date) {
									Text("Last Full Service")
								}
								Text("Full Service includes Lowers Service")
							}
						}
						Toggle(isOn: $lowersForkServiceToggle.animation(), label: {Text("Lowers Serviced")})
						if lowersForkServiceToggle  {
							DatePicker(selection: $fLowersServicedDate, in: ...Date(), displayedComponents: .date) {
								Text("Last Lowers Service ")
							}
						}
						
					}
				}
				
				Section(header: Text("Rear Service")){
					VStack {
// TODO: Set toggle so that if full is open you cannot do airCan & includes text field telling user
// Setup if statements for shock type
						
						Toggle(isOn: $fullRearServiceToggle.animation(), label: {Text("Full Service")})
						if fullRearServiceToggle  {
							VStack() {
								DatePicker(selection: $rFullServiceDate, in: ...Date(), displayedComponents: .date) {
									Text("Last FullService")
								}
								Text("Full Service includes AirCan Service")
							}
						}
						Toggle(isOn: $airCanServiceToggle.animation(), label: {Text("Air Can Serviced")})
						if airCanServiceToggle  {
							DatePicker(selection: $rAirCanServiceDate, in: ...Date(), displayedComponents: .date) {
								Text("Last AirCan Service ")
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
		let newService = RearService(context: moc)
		newService.fullService = self.rFullServiceDate
	}
}


