//
//  FilteredBikeListView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/16/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData


struct FilteredBikeListView<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var bikes: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { bike in
            self.content(bike)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", filterKey, filterValue))
        self.content = content
    }
}

//struct FilteredBikeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredBikeListView()
//    }
//}
