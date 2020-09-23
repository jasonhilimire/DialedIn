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
						
						Text("Add Note")
							.font(.title)
							.foregroundColor(Color.white)
							.multilineTextAlignment(.center)
							.frame(maxWidth: .infinity, maxHeight: .infinity)
							.background(Color.blue)
							.cornerRadius(20)
//							.padding()
					}

					Spacer()
					
					NavigationLink(destination: ServiceView()) {
						
						Text("Add Service")
							.font(.title)
							.foregroundColor(Color.white)
							.multilineTextAlignment(.center)
							.frame(maxWidth: .infinity, maxHeight: 150)
							.background(Color.green)
							.cornerRadius(20)
					}
					Spacer()
					
					NavigationLink(destination: AddBikeView()) {
						
						Text("Add Bike")
							.font(.title)
							.foregroundColor(Color.white)
							.multilineTextAlignment(.center)
							.frame(maxWidth: .infinity, maxHeight: 80)
							.background(Color.pink)
							.cornerRadius(20)
					}
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
