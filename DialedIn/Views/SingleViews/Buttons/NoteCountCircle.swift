//
//  NoteCountCircle.swift
//  DialedIn
//
//  Created by Jason Hilimire on 4/22/23.
//  Copyright © 2023 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoteCountCircle: View {
    @Binding var buttonText: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 25, height: 25)
            Text("\(buttonText)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            }
                .clipShape(Circle())
//                .customTextShadow()
    }
}

struct NoteCountCircle_Previews: PreviewProvider {
    static var previews: some View {
        NoteCountCircle(buttonText: .constant(10))
    }
}
