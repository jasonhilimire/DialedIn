//
//  AddNoteFrontSetup.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import TextFieldStepper


struct NoteFrontSetupView: View {
    @ObservedObject var front = NoteFrontSetupViewModel()
	@ObservedObject var noteVM = NoteViewModel()
	@ObservedObject var forkVM = ForkViewModel()
		
	var haptic = UIImpactFeedbackGenerator(style: .light)
	var isDetailEdit: Binding<Bool>?
	
	let note : Notes?
   
	
// MARK: - BODY -
    var body: some View {
        
		Section(header: HStack {
            if (isDetailEdit != nil) {
                Button(action: {
                    noteVM.isFrontEdit.toggle()
                    noteVM.getNoteFront(note: note!)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .scaledToFit()
                        .foregroundColor(.gray)
                }
                Spacer()
                Image("bicycle-fork")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .scaledToFit()
                Text("Front Suspension Details").font(.title2)
                Spacer()
            } //: HSTACK
            }
		) {
			VStack {
					  // AirPressure
                TextFieldStepper(doubleValue: $noteVM.fAirVolume, config: frontAirConfig)
                if forkVM.dualAir == true {
                    TextFieldStepper(doubleValue: $noteVM.fAirVolume2, label: "Secondary Air", config: frontAirConfig)
                }
                Divider()
					//Sag
                TextFieldStepper(doubleValue: $noteVM.fSagSetting.dbl, label: calcSagString(sag: Double(self.noteVM.fSagSetting), travel: forkVM.travel), config: sagConfig)
                Divider()

					// Tokens
                TextFieldStepper(doubleValue: $noteVM.fTokenSetting.dbl, config: tokenConfig)
                Divider()
            
					//Compression
				if forkVM.dualCompression == true {
                    TextFieldStepper(doubleValue: $noteVM.fHSCSetting.dbl, unit: " - HSC", label: "High Speed Compression", config: clickConfig2)
                    TextFieldStepper(doubleValue: $noteVM.fLSCSetting.dbl, unit: " - LSC", label: "Low Speed Compression", config: clickConfig)
                    Divider()
					} else {
                        TextFieldStepper(doubleValue: $noteVM.fCompSetting.dbl, label: "Compression", config: clickConfig)
                        Divider()
					}

					// Rebound
				if forkVM.dualRebound == true {
                    TextFieldStepper(doubleValue: $noteVM.fHSRSetting.dbl, unit: " - HSR", label: "High Speed Rebound", config: clickConfig2)
                    TextFieldStepper(doubleValue: $noteVM.fLSRSetting.dbl, unit: " - LSR", label: "Low Speed Rebound", config: clickConfig)
                    Divider()
					} else {
                        TextFieldStepper(doubleValue: $noteVM.fReboundSetting.dbl, label: "Rebound", config: clickConfig)
                        Divider()
					}
					// Tire Pressure
                TextFieldStepper(doubleValue: $noteVM.fTirePressure, config: tireConfig)
//                Divider()
			}
		}
        .ignoresSafeArea(.keyboard)
	}
}



