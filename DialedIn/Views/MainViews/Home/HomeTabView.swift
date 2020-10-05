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
	

	// MARK: - BODY -
    var body: some View {
// TODO: WRAP IN A NAVIGATION VIEW? or at least add a custom header
// TODO : ADD BUTTONS To SHOW sheets for adding Notes /  service / bike
		VStack{
			HomeNoteView()
			HomeServiceView()
		}
		.padding()
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
