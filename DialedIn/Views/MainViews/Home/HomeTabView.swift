//
//  HomeTabView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
	// MARK: - PROPERTIES -
	@State var addNote = "Add Note"
	@State var addService = "Add Service"

	// MARK: - BODY -
    var body: some View {
// TODO: WRAP IN A NAVIGATION VIEW? or at least add a custom header
// TODO : ADD BUTTONS To SHOW sheets for adding Notes /  service / bike
		NavigationView() {
			VStack{
				Text("Last Note Added")
					.font(.title2)
				HomeNoteView()
				HStack {
					Button(action: {
						print("Add Note Pressed")
					}) {
						HStack {
							Image(systemName: "gauge.badge.plus")
							Text("Add Note")
						}
					}.buttonStyle(GradientButtonStyle())
					
					Spacer()
					Button(action: {
						print("Add Service Pressed")
					}) {
						HStack {
							Image(systemName: "wrench")
							Text("Add Service")
						}
					}.buttonStyle(GradientButtonStyle())
				}
				HomeServiceView()
			}
			.padding()
			.navigationTitle("Dialed In")
		}
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
