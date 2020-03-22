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
	
	@State private var fullForkServiceDone = false
	@State private var lowersForkServiceDone = false
	@State private var fLowersServicedDate = Date()
	@State private var fFullServicedDate = Date()
	
	@State private var fullRearServiceDone = false
	@State private var airCanServiceDone = false
	@State private var rAirCanServiceDate = Date()
	@State private var rFullServiceDate = Date()
	
	
	// if service not done need to call model and set to last service date silently
	
	let bike: Bike
	
    var body: some View {
		NavigationView {
			Form{
				Section {
					Text("Bike: \(self.bike.name ?? "Unknown Bike")").bold()
				}
				
				Section(header: Text("Front Service")){
					Text("")
				}
				
			} // end form
				.onAppear(perform: {self.setup()})
				.navigationBarTitle("DialedIn", displayMode: .inline)
			
			Button(action: {
				//dismisses the sheet
				self.presentationMode.wrappedValue.dismiss()
				self.saveService()
				
				try? self.moc.save()
			}) {
				SaveButtonView()
			}
			
		}
        
    }
	
	func setup() {
		//
	}
	
	func saveService() {
		//
	}
}


