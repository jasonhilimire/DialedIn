//
//  FilteredBikeList.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FilteredBikeList: View {
    
    var fetchRequest: FetchRequest<Bike>
    @State private var bikeName = ""
       
       init(filter: String) {
           fetchRequest = FetchRequest<Bike>(entity: Bike.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS %@", filter))
       }

    var body: some View {
        
        List(fetchRequest.wrappedValue, id: \.self) { bike in
            Text("\(bike.wrappedBikeName)")
        }
    }
}

struct FilteredBikeList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredBikeList(filter: "Unknown Bike")
    }
}
