//
//  AddNoteFrontSetup.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteFrontSetupView: View {
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
       
    // Get All the bikes for the PickerView
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest()) var bikes: FetchedResults<Bike>
    @ObservedObject var frontsetup = NoteFrontSetupModel()
    
    @State private var fCompressionToggle = true
    @State private var fReboundToggle = true
    @State private var bikeNameIndex = 0
    
    
 //TODO: Configure Booleans
    var body: some View {
        VStack{
              // AirPressure
        HStack{
            Text("PSI: \(frontsetup.lastFAirSetting, specifier: "%.1f")")
            Slider(value: $frontsetup.lastFAirSetting, in: 45...120, step: 0.5)
            }
        
            // Tokens
        Stepper(value: $frontsetup.lastFTokenSetting   , in: 0...6, label: {Text("Tokens: \(self.frontsetup.lastFTokenSetting)")})
            
            //Compression
            if fCompressionToggle == true {
                Stepper(value: $frontsetup.lastFHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.frontsetup.lastFHSCSetting)")})
                Stepper(value: $frontsetup.lastFHSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.frontsetup.lastFHSCSetting)")})
            } else {
                Stepper(value: $frontsetup.lastFCompSetting, in: 0...25, label: {Text("Compression: \(self.frontsetup.lastFCompSetting)")})
            }

            // Rebound

            if fReboundToggle == true {
                Stepper(value: $frontsetup.lastFHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.frontsetup.lastFHSRSetting)")})
                Stepper(value: $frontsetup.lastFLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.frontsetup.lastFLSRSetting)")})
            } else {
                Stepper(value: $frontsetup.lastFHSRSetting, in: 0...25, label: {Text("Rebound: \(self.frontsetup.lastFCompSetting)")})
            }
        }
    }
}


struct AddNoteFrontSetup_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteFrontSetupView()
    }
}

