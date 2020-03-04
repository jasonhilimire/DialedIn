//
//  AddNoteRearSetupView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteRearSetupView: View {
    @ObservedObject var rear = NoteRearSetupModel()

//TODO, SET BOOLEANS
    var body: some View {
        VStack {
            if rear.hasRear == false {
                Text("Hardtail")
            } else {
                // Air - Coil
                if rear.coil == false {
                    HStack{
                        Text("PSI: \(self.rear.lastRAirSpringSetting, specifier: "%.0f")")
                        Slider(value: $rear.lastRAirSpringSetting, in: 100...350, step: 1.0)
                       }
                    } else {
                        HStack{
                            Text("Spring: \(self.rear.lastRAirSpringSetting, specifier: "%.0f")")
                            Slider(value: $rear.lastRAirSpringSetting, in: 300...700, step: 25)
                        }
                    }
                //Sag
                Stepper(value: $rear.lastRSagSetting   , in: 0...40, label: {Text("Sag: \(self.rear.lastRSagSetting)")})
                //Tokens
                Stepper(value: $rear.lastRTokenSetting, in: 0...6, label: {Text("Tokens: \(self.rear.lastRTokenSetting)")})
                //Compression
                if rear.rComp == true {
                        Stepper(value: $rear.lastRHSCSetting, in: 0...25, label: {Text("High Sp Comp: \(self.rear.lastRHSCSetting)")})
                        Stepper(value: $rear.lastRLSCSetting, in: 0...25, label: {Text("Low Sp Comp: \(self.rear.lastRLSCSetting)")})
                    } else {
                        Stepper(value: $rear.lastRCompSetting, in: 0...25, label: {Text("Compression: \(self.rear.lastRCompSetting)")})
                    }
                    
                // Rebound
                if rear.rReb == true {
                        Stepper(value: $rear.lastRHSRSetting, in: 0...25, label: {Text("High Sp Rebound: \(self.rear.lastRHSRSetting)")})
                        Stepper(value: $rear.lastRLSRSetting, in: 0...25, label: {Text("Low Sp Rebound: \(self.rear.lastRLSRSetting)")})
                    } else {
                        Stepper(value: $rear.lastRReboundSetting, in: 0...20, label: {Text("Rebound: \(self.rear.lastRReboundSetting)")})
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
