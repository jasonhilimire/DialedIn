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
    
    // bool to show the Sheet
    @State private var showingAddScreen = false

	var body: some View {
		NavigationView {
			List {
				ForEach(bikes, id: \.self) { bike in
					NavigationLink(destination: BikeDetailView(bike: bike)) {
					BikeStyledCellView(bike: bike)
					.padding(10)
					}
				}
			}
			.navigationBarTitle("Bikes")
			.navigationBarItems(leading: EditButton().foregroundColor(Color.white), trailing:
				Button(action: {self.showingAddScreen.toggle()
				}) {
					Image(systemName: "plus.circle").foregroundColor(Color.white)
			})
				.sheet(isPresented: $showingAddScreen)  {
					AddBikeView().environment(\.managedObjectContext, self.moc)
			}
		}
		
	}
}

struct BikeListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeListView()
    }
}



