//
//  Nav_Button.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/5/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct Nav_Button: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .foregroundColor(.white)
                .background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]) , startPoint: .top, endPoint: .bottom)))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .animation(.spring())
                .customShadow()
                .labelStyle(.iconOnly)
        }
}
