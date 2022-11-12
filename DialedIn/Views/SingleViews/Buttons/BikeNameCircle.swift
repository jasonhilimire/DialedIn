//
//  BikeNameCircle.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/11/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeNameCircle: View {
    @Binding var buttonText: String
    
    var body: some View {
        Text("\(buttonText)")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color.orange)
            .frame(width: 50, height: 50, alignment: .center)
            .padding()
            .overlay(
                Circle()
                .stroke(Color.orange, lineWidth: 6)
                .padding(6)
            )
    }
}

struct BikeNameCircle_Previews: PreviewProvider {
    static var previews: some View {
        BikeNameCircle(buttonText: .constant("T"))
    }
}
