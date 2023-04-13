//
//  AddNoteRearSetupView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import TextFieldStepper

struct NoteRearSetupView: View {
    @ObservedObject var rear = NoteRearSetupViewModel()
	@ObservedObject var rearVM = RearShockViewModel()
	@ObservedObject var noteVM = NoteViewModel()
	
	var haptic = UIImpactFeedbackGenerator(style: .light)
	var isDetailEdit: Binding<Bool>?
	
	let note : Notes?

    var body: some View {
		Section(header:
					HStack {
						if (isDetailEdit != nil) {
							Button(action: {
								noteVM.isRearEdit.toggle()
								noteVM.getNoteRear(note: note!)
							}) {
								Image(systemName: "xmark.circle.fill")
									.resizable()
									.frame(width: 15, height: 15)
									.scaledToFit()
									.foregroundColor(.gray)
							}
						
						Spacer()
						Image("shock-absorber")
							.resizable()
							.frame(width: 45, height: 45)
							.scaledToFit()
						Text("Rear Suspension Details")
						Spacer()
					}
                }
		) {
			VStack {
				if rear.hasRear == false {
					Text("Hardtail").fontWeight(.thin)
				} else {
					// Air - Coil
					if rearVM.isCoil == false {
                        TextFieldStepper(doubleValue:  $noteVM.rSpring, maximum: 600.0, config: frontAirConfig)
                        
                        Divider()
						} else {
                            TextFieldStepper(doubleValue: $noteVM.rSpring, config: coilConfig)
                            Divider()
						}
					//Sag
                    TextFieldStepper(doubleValue: $noteVM.rSagSetting.dbl, label: calcSagString(sag: Double(self.noteVM.rSagSetting), travel: rearVM.travel), config: sagConfig)
                    Divider()

					//Tokens- only if NOT coil
					if rearVM.isCoil == false {
                        TextFieldStepper(doubleValue: $noteVM.rTokenSetting.dbl, config: tokenConfig)
					}
					
                    Divider()
                    
					//Compression
					if rearVM.dualCompression == true {
                        TextFieldStepper(doubleValue: $noteVM.rHSCSetting.dbl, unit: " - HSC", label: "High Speed Compression", config: clickConfig)
                        TextFieldStepper(doubleValue: $noteVM.rLSCSetting.dbl, unit: " - LSC", label: "Low Speed Compression", config: clickConfig2)
                        Divider()
						} else {
                            TextFieldStepper(doubleValue: $noteVM.rCompSetting.dbl, label: "Compression", config: clickConfig)
                            Divider()
						}
						
					// Rebound
					if rearVM.dualRebound == true {
                        TextFieldStepper(doubleValue: $noteVM.rHSRSetting.dbl, unit: " - HSR", label: "High Speed Rebound", config: clickConfig)
                        TextFieldStepper(doubleValue: $noteVM.rLSRSetting.dbl, unit: " - LSR", label: "Low Speed Rebound", config: clickConfig2)
                        Divider()
						} else {
                            TextFieldStepper(doubleValue: $noteVM.rReboundSetting.dbl, label: "Rebound", config: clickConfig)
                            Divider()
						}
					
					//Tire Pressure
                    TextFieldStepper(doubleValue: $noteVM.rTirePressure, config: tireConfig)
				}
			}
		}

    }
	
}


