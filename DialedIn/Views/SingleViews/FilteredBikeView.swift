//
//  FilteredBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/28/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FilteredBikeView: View {
	@Environment(\.managedObjectContext) var moc
	@State private var bikeName = ""
	
	var fetchRequest: FetchRequest<Bike>
	
	init(filter: String) {
		fetchRequest = FetchRequest<Bike>(entity: Bike.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
	}
    var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { bike in
			Text("\(bike.wrappedBikeName)")
		}
    }
}

struct FilteredBikeView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredBikeView(filter: "filter")
    }
}
