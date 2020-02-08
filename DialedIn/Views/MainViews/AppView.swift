//
//  AppView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.lightGray
    }
    
    var body: some View {
        TabView {
            //TODO: Add Scrolling/Main View for recent notes? and or TopRated Notes
            // https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-horizontal-and-vertical-scrolling-using-scrollview
            // https://www.youtube.com/watch?v=EBbhIbI2Hg8
            //
            
            
            NotesListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Notes")
                }
            
            BikeListView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Bike")
                }
        }
        .accentColor(.white)
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
