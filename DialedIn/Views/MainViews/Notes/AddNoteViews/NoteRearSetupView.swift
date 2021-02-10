//
//  AddNoteRearSetupView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoteRearSetupView: View {
    @ObservedObject var rear = NoteRearSetupModel()
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
						}
						Spacer()
						Image("shock-absorber")
							.resizable()
							.frame(width: 50, height: 50)
							.scaledToFit()
						Text("Rear Suspension Details")
						Spacer()
					}
		) {
			VStack {
				if rear.hasRear == false {
					Text("Hardtail").fontWeight(.thin)
				} else {
					// Air - Coil
					if rear.coil == false {
						HStack{
							Text("PSI: \(self.noteVM.rSpring, specifier: "%.0f")").fontWeight(.thin)
							Slider(value: $noteVM.rSpring, in: 150...350, step: 1.0)
							Stepper(value: $noteVM.rSpring   , in: 150...350, step: 1.0, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Spring: \(self.noteVM.rSpring)")}).labelsHidden()
						   }
						} else {
							HStack{
								Text("Spring: \(self.noteVM.rSpring, specifier: "%.0f")").fontWeight(.thin)
								Slider(value: $noteVM.rSpring, in: 300...700, step: 25)
								Stepper(value: $noteVM.rSpring   , in: 300...700, step: 25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Spring: \(self.noteVM.rSpring)")}).labelsHidden()
							}
						}
					//Sag
					Stepper(value: $noteVM.rSagSetting  , in: 0...50, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag (mm): \(self.noteVM.rSagSetting) -- Sag %: \(calcSag(sag: Double(self.noteVM.rSagSetting), travel: rear.travel), specifier: "%.1f")").fontWeight(.thin)})
					
					
					//Tokens- only if a coil
					if rear.coil == false {
						Stepper(value: $noteVM.rTokenSetting, in: 0...6, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Tokens: \(self.noteVM.rTokenSetting)").fontWeight(.thin)})
					}
					
					//Compression
					if rear.rComp == true {
						Stepper(value: $noteVM.rHSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Comp: \(self.noteVM.rHSCSetting)").fontWeight(.thin)})
						Stepper(value: $noteVM.rHSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Comp: \(self.noteVM.rLSCSetting)").fontWeight(.thin)})
						} else {
							Stepper(value: $noteVM.rCompSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Compression: \(self.noteVM.rCompSetting)").fontWeight(.thin)})
						}
						
					// Rebound
					if rear.rReb == true {
						Stepper(value: $noteVM.rHSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Rebound: \(self.noteVM.rHSRSetting)").fontWeight(.thin)})
						Stepper(value: $noteVM.rLSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Rebound: \(self.noteVM.rLSRSetting)").fontWeight(.thin)})
						} else {
							Stepper(value: $noteVM.rReboundSetting, in: 0...20, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Rebound: \(self.noteVM.rReboundSetting)").fontWeight(.thin)})
						}
					
					//Tire Pressure
					HStack {
						Text("Tire PSI: \(noteVM.rTirePressure, specifier: "%.1f")").fontWeight(.thin)
						Slider(value: $noteVM.rTirePressure, in: 0...40, step: 0.5)
						Stepper(value: $noteVM.rTirePressure, in: 0...40, step: 0.1, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.noteVM.rTirePressure)").fontWeight(.thin)}).labelsHidden()
					}
					
				}
			}
		}
    }
	
}


