//
//  HomeServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeServiceView: View {
	
	@Environment(\.managedObjectContext) var moc
	
	var fetchRequest: FetchRequest<FrontService>
	
	
	
	init(){
		let request: NSFetchRequest<FrontService> = FrontService.lastFrontServiceFetchRequest()
		fetchRequest = FetchRequest<FrontService>(fetchRequest: request)
	}
	
	// SHOW THE LAST SERVICES ADDED
	// Fetch the Bike.fork.frontservices sorted by date with a fetchlimit = 1, which will give the last record, do the same for the rear if bike names are different??? ensure show the names on the labels
	
	
	@State private var bikeName = ""
	
	var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { service in
			FrontServiceHomeView(frontService: service)
		}
		

		.foregroundColor(Color.white)
		.multilineTextAlignment(.center)
		
		//		}
		
		.frame(maxWidth: .infinity, maxHeight: 150)
		.background(LinearGradient(gradient: Gradient(colors: [.green, .purple]), startPoint: .top, endPoint: .bottom))
		.cornerRadius(20)
	}
}


struct FrontServiceHomeView: View {
	//	@ObservedObject var frontService = FrontServiceModel()
	let frontService: FrontService
	
	var body: some View {
		VStack {
			Text("Bike: \(frontService.service?.bike?.name ?? "Bike Not Found")")
			Text("Note:\(frontService.serviceNote ?? "") ")
			Text(frontService.lowersService != nil ? "Lowers: \(frontService.lowersService!, formatter: dateFormatter)" : "")
			Text(frontService.fullService != nil ? "Full: \(frontService.fullService!, formatter: dateFormatter)" : "")
		}
	}
	
}
