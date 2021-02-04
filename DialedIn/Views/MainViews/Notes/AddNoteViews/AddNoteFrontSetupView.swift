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
	@ObservedObject var noteModel = NoteViewModel()
	
	@State private var sag = 20
	@Binding var fAirSetting: Double
	@Binding var fCompression: Int16
	@Binding var fHSC: Int16
	@Binding var fLSC: Int16
	@Binding var fRebound: Int16
	@Binding var fHSR: Int16
	@Binding var fLSR: Int16
	@Binding var fTokens: Int16
	@Binding var fSag: Int16
	@Binding var fTirePressure: Double
	
	
	
	var haptic = UIImpactFeedbackGenerator(style: .light)
	var isDetailEdit: Binding<Bool>?
	let note : Notes?
	

    
// MARK: - BODY -
    var body: some View {
		Section(header:
					HStack {
						Image("bicycle-fork")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Front Suspension Details")
					}
				
		) {
			VStack{
					  // AirPressure
				HStack{
					Text("PSI: \(fAirSetting, specifier: "%.1f")").fontWeight(.thin)
					Slider(value: $fAirSetting, in: 45...150, step: 1.0)
					Stepper(value: $fAirSetting, in: 45...150, step: 0.5, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.fAirSetting)").fontWeight(.thin)}).labelsHidden()

					}
					
					//Sag
					Stepper(value: $fSag   , in: 0...70, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag (mm): \(self.fSag) -- Sag %: \(calcSag(sag: Double(self.fSag), travel: front.fTravel), specifier: "%.1f")").fontWeight(.thin)})
				
					// Tokens
					Stepper(value: $fTokens, in: 0...8, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Tokens: \(self.fTokens)").fontWeight(.thin)})

					
					//Compression
					if front.fComp == true {
						Stepper(value: $fHSC, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Comp: \(self.fHSC)").fontWeight(.thin)})
						Stepper(value: $fLSC, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Comp: \(self.fLSC)").fontWeight(.thin)})
					} else {
						Stepper(value: $fCompression, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Compression: \(self.fCompression)").fontWeight(.thin)})
					}

					// Rebound

					if front.fReb == true {
						Stepper(value: $fHSR, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Rebound: \(self.fHSR)").fontWeight(.thin)})
						Stepper(value: $fLSR, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Rebound: \(self.fLSR)").fontWeight(.thin)})
					} else {
						Stepper(value: $fRebound, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Rebound: \(self.fRebound)").fontWeight(.thin)})
					}
					
					// Tire Pressure
					HStack {
						Text("Tire PSI: \(fTirePressure, specifier: "%.1f")").fontWeight(.thin)
						Slider(value: $fTirePressure, in: 0...40, step: 0.5)
						Stepper(value: $fTirePressure, in: 0...40, step: 0.1, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.fTirePressure)").fontWeight(.thin)}).labelsHidden()
					}
			}.onAppear(perform: {self.setup(isEdit: (isDetailEdit != nil))})
		}
	}
	
	
	func setup(isEdit: Bool) {
		if isEdit == true {
			fAirSetting = note?.fAirVolume ?? 0.0
		}
		fAirSetting = front.getLastAir()
	}
}

///


