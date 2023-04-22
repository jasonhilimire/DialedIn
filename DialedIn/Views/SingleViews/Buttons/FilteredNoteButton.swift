//
//  FilteredNoteButton.swift
//  DialedIn
//
//  Created by Jason Hilimire on 4/22/23.
//  Copyright © 2023 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FilteredNoteButton: View {
    @Binding var buttonText: String
    @Binding var noteCount: Int
    
    var body: some View {
            HStack(spacing: 8) {
                Text("\(buttonText)")
                
                NoteCountCircle(buttonText: $noteCount)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
         //: Button
            .accentColor(Color.white)
            .customTextShadow()
    }
}

//struct FilteredNoteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredNoteButton()
//    }
//}
