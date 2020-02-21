//
//  BikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct BikeDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingDeleteAlert = false
    
    let bike: Bike
    var body: some View {
        Text("\(bike.name ?? "Unknown Bike")")
    }
}

struct BikeDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let bike = Bike(context: moc)

        return NavigationView {
            BikeDetailView(bike: bike)
        }
    }
}
