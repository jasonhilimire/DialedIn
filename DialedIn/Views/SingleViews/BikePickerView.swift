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
       @FetchRequest(entity: Bike.entity(), sortDescriptors: [
           NSSortDescriptor(keyPath: \Bike.name, ascending: true)
       ]) var bikes: FetchedResults<Bike>
       
    @State var bikeName = ""
    
    var body: some View {
            Picker(selection: $bikeName, label: Text("Choose Bike")) {
            ForEach(bikes, id: \.self) { bike in Text(bike.wrappedBikeName).tag(bike.wrappedBikeName)}
            }
    }
}

struct BikePickerView_Previews: PreviewProvider {
    static var previews: some View {
        BikePickerView()
    }
}
