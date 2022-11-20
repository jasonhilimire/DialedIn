//
//  CircularSliderView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/19/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import SwiftUI


import SwiftUI
import CircularSlider

struct CircularSliderView: View {
    @Binding var sliderVal : Double
    @Binding var maxSliderValue : Double
    @Binding var circleText: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("TextEditBackgroundColor"))
                .edgesIgnoringSafeArea(.all)
            
            CircularSlider(
                currentValue: self.$sliderVal,
                minValue: 1,
                maxValue: self.maxSliderValue,
                knobColor: .init(red: 0.5, green: 0.5, blue: 0.5),
                progressLineColor: .init(red: 0.94, green: 0.63, blue: 0.09),
                font: .custom("HelveticaNeue-Light", size: 35),
                backgroundColor: Color("TextEditBackgroundColor"),
                currentValueSuffix: circleText)
        }
    }
}
