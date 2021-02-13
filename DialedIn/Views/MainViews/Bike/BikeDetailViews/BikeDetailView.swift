//
//  BikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct BikeDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
	
	@State private var bikeName = ""

    let bike: Bike
	
    var body: some View {
		VStack{
			VStack {
				Text("Note: \(self.bike.bikeNote ?? "")" )
					.font(.subheadline)
					.customTextShadow()
					.fixedSize(horizontal: false, vertical: true)
					.padding(2)
				VStack {
					Section {
						ForkLastServicedView(bike: self.bike)
					}
					Divider()
					Section{
						if self.bike.hasRearShock == false {
							Text("HardTail")
						} else {
							RearShockLastServicedView(bike: self.bike)
						}
					}
					Divider()
				}
			}
			Spacer(minLength:5)

			FilteredBikeNotesView(filter: self.bikeName)
				.padding(.horizontal)
			
		}
    }
}



