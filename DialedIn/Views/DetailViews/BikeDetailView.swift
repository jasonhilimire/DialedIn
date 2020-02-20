//
//  BikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let bike: Bike
    
    var body: some View {
        VStack {
            Text(self.bike.name ?? "Unknown Bike")
                .font(.largeTitle)
            Text("Info: \(self.bike.bikeNote ?? "")" )
                .font(.subheadline)
            
            Section(header: Text("Fork")) {
                Text("Last Lowers Service:")
                Text("Last Full Service:")
            }
            
            Section(header: Text("Rear")) {
                if self.bike.hasRearShock == false {
                    Text("HardTail")
                } else if self.bike.rearSetup?.isCoil == true{
                    Text("Last Full Service: ")
                } else {
                    Text("Last AirCan Service:")
                    Text("Last Full Service:")
                    
                }
            }
            
        }
    }
}
//
//struct BikeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        bike.name = "Test Bike"
//
//        return NavigationView {
//            BikeDetailView(bike: bike)
//        }
//    }
//}

