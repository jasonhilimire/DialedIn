//
//  OrangeToggleStyle.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/28/23.
//  Copyright © 2023 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct OrangeToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(.orange) // set the toggle color to orange
                    .imageScale(.large) // set the image scale to medium
                    .font(.system(size: 22)) // set the font size based on the toggle state
            }
        }
        .foregroundColor(.primary)
    }
}
