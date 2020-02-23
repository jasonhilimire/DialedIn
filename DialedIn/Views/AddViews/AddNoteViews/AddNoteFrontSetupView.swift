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
    
    
    var body: some View {
              // AirPressure
        HStack{
            Text("PSI: \(frontsetup.lastFAirSetting, specifier: "%.1f")")
            Slider(value: $frontsetup.lastFAirSetting, in: 45...120, step: 0.5)
        }

        
            // Tokens
//        Stepper(value: $frontSetup.lastFTokenSetting    , in: 0...6, label: {Text("Tokens: \(self.frontSetup.lastFTokenSetting)")})
            
//            //Compression
//            if fCompressionToggle == true {
//                Stepper(value: $frontSetup.lastFHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.frontSetup.lastFHSCSetting)")})
//                Stepper(value: $frontSetup.lastFLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.frontSetup.lastFLSCSetting)")})
//            } else {
//                Stepper(value: $frontSetup.lastFCompSetting, in: 0...25, label: {Text("Compression: \(self.frontSetup.lastFCompSetting)")})
//            }
//
//            // Rebound
//
//            if fReboundToggle == true {
//                Stepper(value: $frontSetup.lastFHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.frontSetup.lastFHSRSetting)")})
//                Stepper(value: $frontSetup.lastFLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.frontSetup.lastFLSRSetting)")})
//            } else {
//                Stepper(value: $frontSetup.lastFReboundSetting, in: 0...25, label: {Text("Rebound: \(self.frontSetup.lastFReboundSetting)")})
//            }
    }
    
    func setup() {
        // TODO: BUG HERE DURING SCROLLING WHERE showing the  picker again resets all the toggles because nothing has been actually saved
        // When returning from Picker View .onAppear Update the model


//        print(bikeName)
        self.fCompressionToggle = self.bikes[bikeNameIndex].frontSetup?.dualCompression ?? true
        self.fReboundToggle = self.bikes[bikeNameIndex].frontSetup?.dualRebound ?? true
        
        
    }
}

//struct AddNoteFrontSetup_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNoteFrontSetupView()
//    }
//}
