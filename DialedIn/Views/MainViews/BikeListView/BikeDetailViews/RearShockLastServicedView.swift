//
//  RearShockLastServicedView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/20/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct RearShockLastServicedView: View {
	
    @Environment(\.managedObjectContext) var moc
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let rear: RearShock
	@ObservedObject var rearService = RearServiceModel()
	
    var body: some View {
		VStack { // Rear Section
			if rear.bike?.hasRearShock == false {
				Text("")
			} else {
				HStack {
					Text("Rear")
						.fontWeight(.bold)
					Spacer()
				}
				.padding([.top, .leading])
				if rear.bike?.rearSetup?.isCoil == false {
					HStack {
						Text("Last Air Can Service:")
						Spacer()
						Text(self.rearService.lastAirServ != nil ? " \(self.rearService.lastAirServ, formatter: self.dateFormatter)" : "Unknown")
					}
					.padding([.leading, .trailing])
					.font(.footnote)
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text(self.rearService.lastFullServ != nil ? " \(self.rearService.lastFullServ, formatter: self.dateFormatter)" : "Unknown")
					}
					.padding(.horizontal)
					.font(.footnote)
				} else {
					HStack {
						Text("Last Full Service:")
						Spacer()
						Text(self.rearService.lastFullServ != nil ?  "\(self.rearService.lastFullServ, formatter: self.dateFormatter)" : "Unknown")
					}
					.padding(.horizontal)
					.font(.footnote)
				}
			}
		}
    }
}

//struct RearShockLastServicedView_Previews: PreviewProvider {
//    static var previews: some View {
//        RearShockLastServicedView()
//    }
//}
