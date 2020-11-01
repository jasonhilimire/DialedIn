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
    
    @ObservedObject var frontService = FrontServiceModel()
	@Binding var bikeName: String
	
//    let fork: Fork
	let bike: Bike
	
	
    var body: some View {
		VStack(alignment: .leading) { // Fork Section
				HStack {
					Image("bicycle-fork")
						.resizable()
						.frame(width: 25, height: 25)
						.scaledToFit()
					Text("\(self.bike.frontSetup?.info ?? "") - \(self.bike.frontSetup?.travel ?? 0.0, specifier: "%.2f")mm")
						.font(.headline)
						.fontWeight(.semibold)
					Spacer()

	//				Text("\(self.bike.frontSetup?.info ?? "")")
				}
				.padding([.top, .leading, .trailing])
				.customShadow()
				
				HStack(alignment: .center) {
					Text("Lowers Last Serviced:")
						.fontWeight(.light)
					Spacer()
					Text( "\(self.frontService.getlowersDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.light)
					
				}
				.padding(.horizontal)
				.font(.footnote)
				
				HStack {
					Text("Last Full Service:")
						.fontWeight(.light)
					Spacer()
					Text("\(self.frontService.getFullDate(bike: self.bikeName), formatter: dateFormatter)")
						.fontWeight(.light)
				}
				.padding(.horizontal)
				.font(.footnote)
				
				HStack {
					Text("\(self.frontService.getFrontServiceNote(bike: self.bikeName))")
					.fontWeight(.light)
				}
				.padding(.horizontal)
				.font(.footnote)
		} .onAppear(perform: {self.setup()})
    }
	
	func setup() {
		bikeName = self.bike.name ?? "Unknown bike"
		frontService.bikeName = bikeName
		frontService.getLastServicedDates()
	}
}

