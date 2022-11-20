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
    let decImage = TextFieldStepperImage(image: Image(systemName: "minus.square.fill"), color: Color.orange)
    let incImage = TextFieldStepperImage(image: Image(systemName: "plus.square.fill"), color: Color.orange )
    let decImage2 = TextFieldStepperImage(image: Image(systemName: "gauge.low"), color: Color.orange)
    let incImage2 = TextFieldStepperImage(image: Image(systemName: "gauge.high"), color: Color.orange )
	
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
                let airconfig = TextFieldStepperConfig(
                    unit: " -PSI",
                    label: "Air Volume",
                    increment: 0.5,
                    minimum: 1.0,
                    maximum: 200.0,
                    decrementImage: decImage,
                    incrementImage: incImage,
                    minimumDecimalPlaces: 1,
                    maximumDecimalPlaces: 1)
                
                TextFieldStepper(doubleValue: $noteVM.fAirVolume, config: airconfig)
                Divider()
                let airconfig2 = TextFieldStepperConfig(
                    unit: " -PSI",
                    label: "Air Volume",
                    increment: 0.5,
                    minimum: 1.0,
                    maximum: 200.0,
                    decrementImage: decImage2,
                    incrementImage: incImage2,
                    minimumDecimalPlaces: 1,
                    maximumDecimalPlaces: 1)
                
                TextFieldStepper(doubleValue: $noteVM.fAirVolume, config: airconfig2)
                
                Divider()
                
                TextFieldStepper(doubleValue: $noteVM.fAirVolume, config: airconfig)
                
                
//					Text("PSI: \(noteVM.fAirVolume, specifier: "%.1f")").fontWeight(.thin)
//					Slider(value: $noteVM.fAirVolume, in: 45...120, step: 1.0).accentColor(.orange)
//					Stepper(value: $noteVM.fAirVolume, in: 45...120, step: 0.5, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.noteVM.fAirVolume)").fontWeight(.thin)}).labelsHidden()

					
//					//Sag
//				Stepper(value: $noteVM.fSagSetting , in: 0...70, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag (mm): \(self.noteVM.fSagSetting) -- Sag %: \(calcSag(sag: Double(self.noteVM.fSagSetting), travel: forkVM.travel), specifier: "%.1f")").fontWeight(.thin)})
//
//					// Tokens
//				Stepper(value: $noteVM.fTokenSetting , in: 0...6, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Tokens: \(self.noteVM.fTokenSetting )").fontWeight(.thin)})
//
//
//					//Compression
//				if forkVM.dualCompression == true {
//						Stepper(value: $noteVM.fHSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Comp: \(self.noteVM.fHSCSetting)").fontWeight(.thin)})
//						Stepper(value: $noteVM.fLSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Comp: \(self.noteVM.fLSCSetting)").fontWeight(.thin)})
//					} else {
//						Stepper(value: $noteVM.fCompSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Compression: \(self.noteVM.fCompSetting)").fontWeight(.thin)})
//					}
//
//					// Rebound
//				if forkVM.dualRebound == true {
//						Stepper(value: $noteVM.fHSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Rebound: \(self.noteVM.fHSRSetting)").fontWeight(.thin)})
//						Stepper(value: $noteVM.fLSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Rebound: \(self.noteVM.fLSRSetting)").fontWeight(.thin)})
//					} else {
//						Stepper(value: $noteVM.fReboundSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Rebound: \(self.noteVM.fReboundSetting)").fontWeight(.thin)})
//					}
//
//					// Tire Pressure
//					HStack {
//						Text("Tire PSI: \(noteVM.fTirePressure, specifier: "%.1f")").fontWeight(.thin)
//						Slider(value: $noteVM.fTirePressure, in: 0...40, step: 0.5).accentColor(.orange)
//						Stepper(value: $noteVM.fTirePressure, in: 0...40, step: 0.1, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.noteVM.fTirePressure)").fontWeight(.thin)}).labelsHidden()
//					}
			}
		}
        .ignoresSafeArea(.keyboard)
	}
}



