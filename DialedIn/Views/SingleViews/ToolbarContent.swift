//
//  ToolbarContent.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/24/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct SheetToolBar: ToolbarContent{
//	var confirmAction: () -> Void
	var cancelAction: () -> Void
//	var destructAction: () -> Void
	
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
			Button(action: {
				cancelAction()
			}, label: {
				Image(systemName: "xmark.circle").foregroundColor(.red)
			})
		}
    }
}

struct NoteToolBar: ToolbarContent{
    @Binding var indx: Int
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            if indx == 1 {
                HStack {
                    HStack {
                        Image("bicycle-fork")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                        Text("Front Suspension Details")
                    }
                }
            } else if indx == 2 {
                HStack {
                    Image("shock-absorber")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Text("Rear Suspension Details")
                }
            } else {
                Text("Add New Note")
            }
        }
    }
}

