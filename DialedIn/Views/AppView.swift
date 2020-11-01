//
//  AppView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
	// GIVES AN ORANGE HEADER
//	init() {
//		UINavigationBar.appearance().backgroundColor = .systemOrange
////		UITabBar.appearance().barTintColor = UIColor.orange
//
//		UINavigationBar.appearance().largeTitleTextAttributes = [
//			.foregroundColor: UIColor.white,
//			.font : UIFont(name:"Helvetica Neue", size: 40)!]
//	}
	
	@AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
        
    var body: some View {
        TabView {
            HomeTabView()
				.tabItem {
					Image(systemName: "house")
					Text("Home")
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
        }
		.animation(.default)
        .accentColor(Color("TextColor"))
		// shows the OnBoarding View
		.sheet(isPresented: $needsAppOnboarding){
			OnBoardingView()
		}
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
