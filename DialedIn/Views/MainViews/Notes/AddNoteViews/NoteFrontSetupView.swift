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
        
		Section(header:
					HStack {
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
						}
						
						Spacer()
						Image("bicycle-fork")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Front Suspension Details")
						Spacer()
					} //: HSTACK
				
		) {
			VStack {
					  // AirPressure
                TextFieldStepper(doubleValue: $noteVM.fAirVolume, config: frontAirConfig)
                Divider()

					//Sag
                TextFieldStepper(doubleValue: $noteVM.fSagSetting.dbl, label: calcSagString(), config: sagConfig)
                Divider()

					// Tokens
                TextFieldStepper(doubleValue: $noteVM.fTokenSetting.dbl, config: tokenConfig)
                Divider()
                
					//Compression
				if forkVM.dualCompression == true {
                    TextFieldStepper(doubleValue: $noteVM.fHSCSetting.dbl, config: hscConfig)
                    TextFieldStepper(doubleValue: $noteVM.fLSCSetting.dbl, config: lscConfig)
                    Divider()
					} else {
                        TextFieldStepper(doubleValue: $noteVM.fCompSetting.dbl, config: compressionConfig)
                        Divider()
					}

					// Rebound
				if forkVM.dualRebound == true {
                    TextFieldStepper(doubleValue: $noteVM.fHSRSetting.dbl, config: hsrConfig)
                    TextFieldStepper(doubleValue: $noteVM.fLSRSetting.dbl, config: lsrConfig)
                    Divider()
					} else {
                        TextFieldStepper(doubleValue: $noteVM.fReboundSetting.dbl, config: reboundConfig)
                        Divider()

					}

					// Tire Pressure
                TextFieldStepper(doubleValue: $noteVM.fTirePressure, config: tireConfig)
                Divider()
			}
		}
        .ignoresSafeArea(.keyboard)
	}
    
    func calcSagString() -> String{
        let sag = calcSag(sag: Double(self.noteVM.fSagSetting), travel: forkVM.travel)
        return "Sag %: \(sag.rounded())"
        
    }
}



