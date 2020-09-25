//
//  HomeNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeNoteView: View {
    var body: some View {
		Text("Add Note")
			.font(.title)
			.foregroundColor(Color.white)
			.multilineTextAlignment(.center)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.blue)
			.cornerRadius(20)
		
		// This will show the very last note created
		// Will allow of a tap to ADD A NEW NOTE
    }
}

struct HomeNoteView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNoteView()
    }
}
