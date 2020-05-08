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
		UINavigationBar.appearance().backgroundColor = .systemOrange
//		UITabBar.appearance().barTintColor = UIColor.orange
		
		UINavigationBar.appearance().largeTitleTextAttributes = [
			.foregroundColor: UIColor.white,
			.font : UIFont(name:"Helvetica Neue", size: 40)!]
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
                    Text("Bikes")
                }
			
        }
        .accentColor(Color("TextColor"))
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
