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
    
 //TODO: Configure Booleans
    var body: some View {
        VStack{
              // AirPressure
        HStack{
            Text("PSI: \(front.lastFAirSetting, specifier: "%.1f")")
            Slider(value: $front.lastFAirSetting, in: 45...120, step: 0.5)
			
			/// Remove the show the PSI setting as 'last PSI' & then determine how to dismiss keyboard
//			TextField("", value: $front.lastFAirSetting, formatter: NumberFormatter()).keyboardType(.decimalPad)
            }
			
            Stepper(value: $front.lastFSagSetting   , in: 0...40, label: {Text("Sag: \(self.front.lastFSagSetting)")})
        
            // Tokens
            Stepper(value: $front.lastFTokenSetting   , in: 0...6, label: {Text("Tokens: \(self.front.lastFTokenSetting)")})

            
            //Compression
            if front.fComp == true {
                Stepper(value: $front.lastFHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.front.lastFHSCSetting)")})
                Stepper(value: $front.lastFLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.front.lastFLSCSetting)")})
            } else {
                Stepper(value: $front.lastFCompSetting, in: 0...25, label: {Text("Compression: \(self.front.lastFCompSetting)")})
            }

            // Rebound

            if front.fReb == true {
                Stepper(value: $front.lastFHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.front.lastFHSRSetting)")})
                Stepper(value: $front.lastFLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.front.lastFLSRSetting)")})
            } else {
                Stepper(value: $front.lastFReboundSetting, in: 0...25, label: {Text("Rebound: \(self.front.lastFReboundSetting)")})
            }
		}.onAppear(perform: {self.printStuff()})
    }
	
	func printStuff() {
		print("PSI: \(front.lastFAirSetting)")
	}
}


struct AddNoteFrontSetup_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteFrontSetupView()
    }
}

