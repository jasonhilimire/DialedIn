//
//  AppView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            //TODO: Add Scrolling View for recent notes? and or TopRated Notes
            // https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-horizontal-and-vertical-scrolling-using-scrollview
            // https://www.youtube.com/watch?v=EBbhIbI2Hg8
            //
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Notes")
                }
            
            BikeView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Bike")
                }
        }
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
