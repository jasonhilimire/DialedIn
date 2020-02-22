//
//  BikeSelectionView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/21/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeSelectionView: View {
    
    // Create the MOC
       @Environment(\.managedObjectContext) var moc
       
    // Get All the bikes for the PickerView
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest()) var bikes: FetchedResults<Bike>
       
//    @Binding var bikeNameIndex: Int
    
    
    var body: some View {
        NavigationView {
        List {
            ForEach(bikes, id: \.self) { bike in
                NavigationLink(destination: AddNoteView(bike: bike)) {
                    VStack(alignment: .leading) {
                        Text(bike.name ?? "Unknown Bike")
                            .font(.headline)
                        Text(bike.bikeNote ?? "Some Text goes here")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Choose a Bike")
        }
    }
}
struct BikeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BikeSelectionView()
    }

}
