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
	var haptic = UIImpactFeedbackGenerator(style: .light)
	
	var isDetailEdit: Binding<Bool>?
	let note : Notes?

//TODO, SET BOOLEANS
    var body: some View {
		Section(header:
					HStack {
						Image("shock-absorber")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Rear Suspension Details")
					}
		) {
			VStack {
				if rear.hasRear == false {
					Text("Hardtail").fontWeight(.thin)
				} else {
					// Air - Coil
					if rear.coil == false {
						HStack{
							Text("PSI: \(self.rear.lastRAirSpringSetting, specifier: "%.0f")").fontWeight(.thin)
							Slider(value: $rear.lastRAirSpringSetting, in: 150...350, step: 1.0)
							Stepper(value: $rear.lastRAirSpringSetting   , in: 150...350, step: 1.0, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag: \(self.rear.lastRAirSpringSetting)")}).labelsHidden()
						   }
						} else {
							HStack{
								Text("Spring: \(self.rear.lastRAirSpringSetting, specifier: "%.0f")").fontWeight(.thin)
								Slider(value: $rear.lastRAirSpringSetting, in: 300...700, step: 25)
								Stepper(value: $rear.lastRAirSpringSetting   , in: 300...700, step: 25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag: \(self.rear.lastRAirSpringSetting)")}).labelsHidden()
							}
						}
					//Sag
					Stepper(value: $rear.lastRSagSetting  , in: 0...50, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag (mm): \(self.rear.lastRSagSetting) -- Sag %: \(calcSag(sag: Double(self.rear.lastRSagSetting), travel: rear.travel), specifier: "%.1f")").fontWeight(.thin)})
					
					
					//Tokens- only if a coil
					if rear.coil == false {
						Stepper(value: $rear.lastRTokenSetting, in: 0...6, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Tokens: \(self.rear.lastRTokenSetting)").fontWeight(.thin)})
					}
					//Compression
					if rear.rComp == true {
							Stepper(value: $rear.lastRHSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Comp: \(self.rear.lastRHSCSetting)").fontWeight(.thin)})
							Stepper(value: $rear.lastRLSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Comp: \(self.rear.lastRLSCSetting)").fontWeight(.thin)})
						} else {
							Stepper(value: $rear.lastRCompSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Compression: \(self.rear.lastRCompSetting)").fontWeight(.thin)})
						}
						
					// Rebound
					if rear.rReb == true {
							Stepper(value: $rear.lastRHSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Rebound: \(self.rear.lastRHSRSetting)").fontWeight(.thin)})
							Stepper(value: $rear.lastRLSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Rebound: \(self.rear.lastRLSRSetting)").fontWeight(.thin)})
						} else {
							Stepper(value: $rear.lastRReboundSetting, in: 0...20, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Rebound: \(self.rear.lastRReboundSetting)").fontWeight(.thin)})
						}
					
					//Tire Pressure
					HStack {
						Text("Tire PSI: \(rear.lastRTirePressure, specifier: "%.1f")").fontWeight(.thin)
						Slider(value: $rear.lastRTirePressure, in: 0...40, step: 0.5)
						Stepper(value: $rear.lastRTirePressure, in: 0...40, step: 0.1, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.rear.lastRTirePressure)").fontWeight(.thin)}).labelsHidden()
					}
					
				}
			}.onAppear(perform: {self.setup(isEdit: (isDetailEdit != nil))})
		}
    }
	
	func setup(isEdit: Bool) {
		if isEdit == true {
			rear.getNoteRearSettings(note: note!)
		}
	}
}


