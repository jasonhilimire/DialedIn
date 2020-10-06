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
            HomeTabView()
				.tabItem {
					Image(systemName: "house")
					Text("Notes")
				}
			
            NotesListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Notes")
                }
            
				BikesView()
                .tabItem {
//					Image("mountainbike")
					Image(systemName: "hare")
                    Text("Bikes")
                }
//			ServiceView()
//				.tabItem {
//					Image(systemName: "wrench")
//					Text("Service")
//			}
			
        }
			.animation(.default)
        .accentColor(Color("TextColor"))
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
