//
//  AddNoteRearSetupView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteRearSetupView: View {
    @ObservedObject var rearSetup = NoteRearSetupModel()

//TODO, SET BOOLEANS
    var body: some View {
        VStack {
            if rearSetup.hasRear == false {
                Text("Hardtail")
            } else {
                // Air - Coil
                if rearSetup.coil == false {
                    HStack{
                        Text("PSI: \(self.rearSetup.lastRAirSpringSetting, specifier: "%.0f")")
                        Slider(value: $rearSetup.lastRAirSpringSetting, in: 100...350, step: 1.0)
                       }
                    } else {
                        HStack{
                            Text("Spring: \(self.rearSetup.lastRAirSpringSetting, specifier: "%.0f")")
                            Slider(value: $rearSetup.lastRAirSpringSetting, in: 300...700, step: 25)
                        }
                    }
                //Tokens
                Stepper(value: $rearSetup.lastRTokenSetting, in: 0...6, label: {Text("Tokens: \(self.rearSetup.lastRTokenSetting)")})
                //Compression
                if rearSetup.rComp == true {
                        Stepper(value: $rearSetup.lastRHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.rearSetup.lastRHSCSetting)")})
                        Stepper(value: $rearSetup.lastRLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.rearSetup.lastRLSCSetting)")})
                    } else {
                        Stepper(value: $rearSetup.lastRCompSetting, in: 0...25, label: {Text("Compression: \(self.rearSetup.lastRCompSetting)")})
                    }
                    
                // Rebound
                if rearSetup.rReb == true {
                        Stepper(value: $rearSetup.lastRHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.rearSetup.lastRHSRSetting)")})
                        Stepper(value: $rearSetup.lastRLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.rearSetup.lastRLSRSetting)")})
                    } else {
                        Stepper(value: $rearSetup.lastRReboundSetting, in: 0...20, label: {Text("Rebound: \(self.rearSetup.lastRReboundSetting)")})
                    }
            }
            
        }
    }
}

struct AddNoteRearSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteRearSetupView()
    }
}
