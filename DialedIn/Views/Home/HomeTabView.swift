//
//  HomeTabView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
	
    var body: some View {
		NavigationView{
			GeometryReader { geometry in
				VStack {
					NavigationLink(destination: AddNoteView()) {
						HomeNoteView()
					}

					Spacer()
					
					NavigationLink(destination: ServiceView()) {
						HomeServiceView()
					}
					Spacer()
					
//					NavigationLink(destination: AddBikeView()) {
//						HomeBikeView()
//					}
				} // end VStack
				.padding()
				.navigationBarTitle("Dialed In")
			}
		}
	}
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			HomeTabView()
			HomeTabView()
				.padding(.all)
		}
    }
}
