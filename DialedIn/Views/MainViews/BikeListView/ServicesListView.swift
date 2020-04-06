//
//  ServicesListView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 4/3/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ServicesListView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	// create a Fetch request for Bike
	@FetchRequest(fetchRequest: FrontService.frontServiceFetchRequest())
	 var frontServices: FetchedResults<FrontService>
	

	
	@ObservedObject var frontServiceModel = FrontServiceModel()
	@ObservedObject var bikeModel = BikeModel()
	@ObservedObject var helper = Helper()
	@Binding var bikeName: String
	
	let bike: Bike
	
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		return formatter
	}
	
	
	init(bike: Bike, bikeName: Binding<String>) {
		self.bike = bike
		self._bikeName = bikeName
		

	}
	
	var body: some View {
		List {
			ForEach(frontServices, id: \.self ) { service in
				HStack{
					Text("\(service.service?.bike?.name ?? "Unknown")")

					Text(service.lowersService != nil ? "\(service.lowersService!, formatter: self.dateFormatter)" : "")
					
				}
				
			}
		}
			

    }
	

}

