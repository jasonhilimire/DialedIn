//
//  AddNoteFrontSetup.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteFrontSetupView: View {
    @ObservedObject var front = NoteFrontSetupModel()
    
    @State private var sag = 20
	let impactLight = UIImpactFeedbackGenerator(style: .light)
    
 //TODO: Configure Booleans
    var body: some View {
        VStack{
              // AirPressure
        HStack{
            Text("PSI: \(front.lastFAirSetting, specifier: "%.1f")").fontWeight(.thin)
            Slider(value: $front.lastFAirSetting, in: 45...120, step: 0.5)
			Stepper(value: $front.lastFAirSetting, in: 45...120, step: 0.5, label: {Text("PSI: \(self.front.lastFAirSetting)").fontWeight(.thin)}).labelsHidden()

            }
			
            Stepper(value: $front.lastFSagSetting   , in: 0...40, label: {Text("Sag: \(self.front.lastFSagSetting)").fontWeight(.thin)})
        
            // Tokens
            Stepper(value: $front.lastFTokenSetting   , in: 0...6, label: {Text("Tokens: \(self.front.lastFTokenSetting)").fontWeight(.thin)})

            
            //Compression
            if front.fComp == true {
                Stepper(value: $front.lastFHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.front.lastFHSCSetting)").fontWeight(.thin)})
                Stepper(value: $front.lastFLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.front.lastFLSCSetting)").fontWeight(.thin)})
            } else {
                Stepper(value: $front.lastFCompSetting, in: 0...25, label: {Text("Compression: \(self.front.lastFCompSetting)").fontWeight(.thin)})
            }

            // Rebound

            if front.fReb == true {
                Stepper(value: $front.lastFHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.front.lastFHSRSetting)").fontWeight(.thin)})
                Stepper(value: $front.lastFLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.front.lastFLSRSetting)").fontWeight(.thin)})
            } else {
                Stepper(value: $front.lastFReboundSetting, in: 0...25, label: {Text("Rebound: \(self.front.lastFReboundSetting)").fontWeight(.thin)})
            }
		}.onAppear(perform: {self.setup()})
	}
	
	func setup() {

//		print("\(bikeName)")
//		fComp = front.getDualComp(bike: bikeName) 
		print("Comp \(front.fComp)")
		print("Reb \(front.fReb)")
	}
	
}



