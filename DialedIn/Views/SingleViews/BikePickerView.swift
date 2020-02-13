//
//  BikePickerView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikePickerView: View {
    
    // Create the MOC
       @Environment(\.managedObjectContext) var moc
       
       // Get All the bikes for the PickerView
    @FetchRequest(fetchRequest: Bike.BikesFetchRequest()) var bikes: FetchedResults<Bike>
       
    @Binding var bikeName: String
    
    var body: some View {
// Picker Works correctly now when sent to AddNoteView, however the name is not binded to anything
//        Picker(selection: self.$bikeName, label: Text("Choose Bike")) {
//            ForEach(0..<bikes.count) { bike in Text("\(self.bikes[bike].name ?? "Unknown bike")")}
//            }
        
            Picker(selection: $bikeName, label: Text("Choose Bike")) {
            ForEach(bikes, id: \.self) { bike in Text(bike.wrappedBikeName).tag(bike.wrappedBikeName)}
            }
    }
}

//struct BikePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        BikePickerView(bikeName: "the bike")
//    }
//}
