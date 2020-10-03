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
		VStack {
			NotesListView() // Seems to work if using this view- so take this view which is reallly just the filtered notes view gut it and get what i need
		}
//			GeometryReader { geometry in
//				VStack {
//					// Cant have this wrapped in a Nav Link- however if a new note is added it seems to not honor the fetch limit? and will duplicate
//					// perhaps a model as i already have in place to get last info for Fork/Shock instead of fetchrequest?
//					// if bikes.count > 0, fetch all notes, get the last bikename from the note then apply to the models
//					HomeNoteView()
//
//
//					Spacer()
//
//					NavigationLink(destination: ServiceView()) {
//						HomeServiceView()
//					}
//					Spacer()
//
////					NavigationLink(destination: AddBikeView()) {
////						HomeBikeView()
////					}
//				} // end VStack
				.padding()
				.navigationBarTitle("Dialed In")
			
	}
}

