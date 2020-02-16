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
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest()) var bikes: FetchedResults<Bike>
       
    @Binding var bikeNameIndex: Int
    
    // eventually change this to pick Default Bike and then change
    var body: some View {
        Picker(selection: self.$bikeNameIndex, label: Text("Choose Bike")) {
        ForEach(0..<bikes.count) { bike in Text("\(self.bikes[bike].name ?? "Unknown bike")")
            }
        }
    }
}

//struct BikePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        BikePickerView(bikeName: "the bike")
//    }
//}
