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
        ZStack {
            Circle()
                .fill(Color.customGradient)
                .frame(width: 50, height: 50)
            Text(buttonText)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
            }
                .clipShape(Circle())
                .customTextShadow()
    }
}

struct BikeNameCircle_Previews: PreviewProvider {
    static var previews: some View {
        BikeNameCircle(buttonText: .constant("M"))
    }
}
