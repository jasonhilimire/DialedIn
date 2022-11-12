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
            .foregroundColor(Color.white)
            .padding()
            .background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom)))
            .clipShape(Circle())
            .frame(width: 50, height: 50, alignment: .center)
            .customTextShadow()
    }
}

struct BikeNameCircle_Previews: PreviewProvider {
    static var previews: some View {
        BikeNameCircle(buttonText: .constant("T"))
    }
}
