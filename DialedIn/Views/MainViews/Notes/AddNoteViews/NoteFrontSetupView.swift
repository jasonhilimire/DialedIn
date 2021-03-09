//
//  AddNoteFrontSetup.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/22/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

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
			VStack{
					  // AirPressure
				HStack{
//					Text("PSI: \(noteVM.fAirVolume, specifier: "%.1f")").fontWeight(.thin)
//					Slider(value: $noteVM.fAirVolume, in: 45...120, step: 1.0)

					CustomSlider(value: $noteVM.fAirVolume, range: (0, 100), knobWidth: 1) { modifiers in
						ZStack {
//							.background (// = Color(red: 0.07, green: 0.07, blue: 0.12)
//							LinearGradient(gradient: .init(colors: [background, Color.black.opacity(0.6) ]), startPoint: .bottom, endPoint: .top))
							
							Group {
								LinearGradient(gradient: .init(colors: [Color.yellow, Color.orange, Color.red ]), startPoint: .leading, endPoint: .trailing)
//								LinearGradient(gradient: .init(colors: [Color.clear, background ]), startPoint: .top, endPoint: .bottom).opacity(0.15)
							}.modifier(modifiers.barLeft)
							
							Text("PSI: \(noteVM.fAirVolume, specifier: "%.1f")").fontWeight(.thin).foregroundColor(Color.white)
						}
						.cornerRadius(8)
					}
					.frame(height: 25)
//					.padding(2)
					.background(
						// adds shadow border around entire slider (to make it appear inset)
						LinearGradient(gradient: .init(colors: [Color.gray, Color.black ]), startPoint: .bottom, endPoint: .top)
							.opacity(0.2)
							.cornerRadius(9)
					)
					
//					Stepper(value: $noteVM.fAirVolume, in: 45...120, step: 0.5, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.noteVM.fAirVolume)").fontWeight(.thin)}).labelsHidden()
//
					}
					
					//Sag
				Stepper(value: $noteVM.fSagSetting , in: 0...70, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Sag (mm): \(self.noteVM.fSagSetting) -- Sag %: \(calcSag(sag: Double(self.noteVM.fSagSetting), travel: forkVM.travel), specifier: "%.1f")").fontWeight(.thin)})
				
					// Tokens
				Stepper(value: $noteVM.fTokenSetting , in: 0...6, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Tokens: \(self.noteVM.fTokenSetting )").fontWeight(.thin)})

					
					//Compression
				if forkVM.dualCompression == true {
						Stepper(value: $noteVM.fHSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Comp: \(self.noteVM.fHSCSetting)").fontWeight(.thin)})
						Stepper(value: $noteVM.fLSCSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Comp: \(self.noteVM.fLSCSetting)").fontWeight(.thin)})
					} else {
						Stepper(value: $noteVM.fCompSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Compression: \(self.noteVM.fCompSetting)").fontWeight(.thin)})
					}

					// Rebound
				if forkVM.dualRebound == true {
						Stepper(value: $noteVM.fHSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("High Sp Rebound: \(self.noteVM.fHSRSetting)").fontWeight(.thin)})
						Stepper(value: $noteVM.fLSRSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Low Sp Rebound: \(self.noteVM.fLSRSetting)").fontWeight(.thin)})
					} else {
						Stepper(value: $noteVM.fReboundSetting, in: 0...25, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("Rebound: \(self.noteVM.fReboundSetting)").fontWeight(.thin)})
					}
					
					// Tire Pressure
					HStack {
						Text("Tire PSI: \(noteVM.fTirePressure, specifier: "%.1f")").fontWeight(.thin)
						Slider(value: $noteVM.fTirePressure, in: 0...40, step: 0.5).accentColor(Color.orange)
						Stepper(value: $noteVM.fTirePressure, in: 0...40, step: 0.1, onEditingChanged: {_ in DispatchQueue.main.async {self.haptic.impactOccurred()}}, label: {Text("PSI: \(self.noteVM.fTirePressure)").fontWeight(.thin)}).labelsHidden()
					}
			}
		}
	}
}



