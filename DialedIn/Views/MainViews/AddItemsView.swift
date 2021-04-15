//
//  AddItemsView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/18/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddItemsView: View {
	// Create the MOC
	@Environment(\.managedObjectContext) var moc
	@State private var addNoteSheet = false
	
    var body: some View {
		VStack{
			Button(action: {addNoteSheet.toggle()}) {
				Text("Add Note")
			}
			Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
		}
		.sheet(isPresented: $addNoteSheet)  {
			AddNoteView().environment(\.managedObjectContext, self.moc)
		}
    }
}

struct AddItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemsView()
    }
}
