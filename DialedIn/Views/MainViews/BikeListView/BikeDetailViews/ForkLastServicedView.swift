//
//  ForkDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/19/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ForkLastServicedView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
	
    @ObservedObject var frontService = FrontServiceModel()
	@State private var bikeName = ""
	
    let fork: Fork
	let bike: Bike
	
    var body: some View {
		VStack { // Fork Section
			HStack {
				Text("Fork")
					.fontWeight(.bold)
				Spacer()
			}
			.padding([.top, .leading])
			HStack(alignment: .center) {
				Text("Lowers Last Serviced:")
				Spacer()
				Text("\(self.frontService.lastLowerService , formatter: self.dateFormatter)")
			}
			.padding(.horizontal)
			.font(.footnote)
			HStack {
				Text("Last Full Service:")
				Spacer()
				Text("\(self.frontService.lastFullService, formatter: self.dateFormatter)")
			}
			.padding(.horizontal)
			.font(.footnote)
		}   .onAppear(perform: {self.setup()})
			.onDisappear(perform: {self.setup()})
    }
	
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
//		print("Full service \(self.frontService.lastFullService)")
	}
}

