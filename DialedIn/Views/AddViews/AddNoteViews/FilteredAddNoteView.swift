//
//  FilteredAddNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/25/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredAddNoteView: View {
	var fetchRequest: FetchRequest<Bike>
	
    var body: some View {
		ForEach(fetchRequest.wrappedValue, id: \.self) { bike in
			Text("\(bike.wrappedBikeName)")
		}
    }
	
	init(filter: String){
		fetchRequest = FetchRequest<Bike>(entity: Bike.entity(), sortDescriptors:[], predicate: NSPredicate(format: "name == %@", filter))
	}
}

//struct FilteredAddNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredAddNoteView()
//    }
//}
