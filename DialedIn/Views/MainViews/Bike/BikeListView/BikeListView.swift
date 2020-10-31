//
//  BikeListView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeListView: View {
        
       // Create the MOC
    @Environment(\.managedObjectContext) var moc
    // create a Fetch request for Bike
    @FetchRequest(entity: Bike.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Bike.name, ascending: true)
    ]) var bikes: FetchedResults<Bike>
    

	var body: some View {
		NavigationView {
			List {
				ForEach(bikes, id: \.self) { bike in
					NavigationLink(destination: BikeDetailView(bike: bike)) {
					BikeStyledCellView(bike: bike)
						.padding(.horizontal, 5)
					}
				}
				.onDelete(perform: deleteBikes) // -- Causes error:  Fatal error: Unexpectedly found nil while unwrapping an Optional value: if ServiceViews are shown
			}
		}
	}
	
	func deleteBikes(at offsets: IndexSet) {
		for offset in offsets {
			// find this note in our fetch request
			let bike = bikes[offset]
			// delete it from the context
			moc.delete(bike)
		}
			// save the context
			try? moc.save()
	}
}

struct BikeListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeListView()
    }
}



