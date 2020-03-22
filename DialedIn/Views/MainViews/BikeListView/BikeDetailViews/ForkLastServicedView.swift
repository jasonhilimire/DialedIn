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
	
    let fork: Fork
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
				Text(self.frontService.lastLowerService != nil ? "\(self.frontService.lastLowerService , formatter: self.dateFormatter)" : "Unknown")
			}
			.padding(.horizontal)
			.font(.footnote)
			HStack {
				Text("Last Full Service:")
				Spacer()
				Text(self.frontService.lastFullService  != nil ? "\(self.frontService.lastFullService, formatter: self.dateFormatter)" : "Unknown")
			}
			.padding(.horizontal)
			.font(.footnote)
		}
        
    }
}

//struct ForkDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForkDetailView()
//    }
//}
