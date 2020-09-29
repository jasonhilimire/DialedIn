//
//  BikesView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikesView: View {
// MARK: - PROPERTIES -
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	// create a Fetch request for Bike
	@FetchRequest(entity: Bike.entity(), sortDescriptors: [
		NSSortDescriptor(keyPath: \Bike.name, ascending: true)
	]) var bikes: FetchedResults<Bike>
	
	// bool to show the Sheet
	@State private var showingAddScreen = false
	
	
// MARK: - BODY -
    var body: some View {
		NavigationView {
			TabView {
				ForEach(bikes, id: \.self) { bike in
						BikeCardView(bike: bike)
				} //: LOOP
			} //: TAB
			.navigationBarTitle("Bikes") // doesnt seem to be working??
			.navigationBarItems(trailing: Button(action: {self.showingAddScreen.toggle()
			}) {
				Image(systemName: "plus.circle").foregroundColor(Color("TextColor"))
					.font(.title)
			})
			.sheet(isPresented: $showingAddScreen)  {
				AddBikeView().environment(\.managedObjectContext, self.moc)
			}
			
			
			.tabViewStyle(PageTabViewStyle())
			.padding(.vertical, 20)
		}
		
	}
	
}

struct BikesView_Previews: PreviewProvider {
    static var previews: some View {
        BikesView()
    }
}
