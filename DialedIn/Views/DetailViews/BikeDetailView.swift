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
            Group {
                Text("\(self.bike.wrappedBikeName)")
                Text("Note: \(self.bike.wrappedBikeNote)")
            }
            Divider()
            Group {
                Text("Front Service").bold()
//                Text(self.bike.frontSetup?.lowerLastServiced != nil ? "\(self.bike.frontSetup?.lowerLastServiced!, formatter: self.dateFormatter)" : "")
//                (self.note.date != nil ? "\(self.note.date!, formatter: self.dateFormatter)" : "")
//                Text("Last Full Service \()")
                
            }
        .onAppear(perform: {print(self.bike.frontSetup?.lowerLastServiced)})
        }
    }
}

//struct BikeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BikeDetailView()
//    }
//}
