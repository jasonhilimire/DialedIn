//
//  RearNoteDetailsView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct RearNoteDetailsView: View {
	
	@ObservedObject var noteModel = EditNoteViewModel()
	
	let note : Notes
    var body: some View {
		Group {
			VStack {
				VStack {
					HStack {
						Image("shock-absorber")
						.resizable()
						.frame(width: 50, height: 50)
						.scaledToFit()
						Text("\(self.note.bike?.rearSetup?.info ?? "Rear Shock Details")")
						.font(.headline)
						.fontWeight(.thin)
						.fixedSize()
					}
				}
			
			Spacer()
			
			VStack {
				if self.note.bike?.hasRearShock == false {
					Text("Hardtail")
					.font(.title)
					.fontWeight(.thin)
					.fixedSize()
				} else {
					VStack{
						HStack{
							Text("Spring: \(noteModel.rSpring, specifier: "%.0f")").customNotesText()
							
							if self.note.bike?.rearSetup?.isCoil == false {
								Text("Tokens: \(noteModel.rTokenSetting)").customNotesText()
							}
						}
					}
					Spacer()
					
					VStack{
						HStack {
							Text("Sag %: \(calcSag(sag: Double(noteModel.rSagSetting), travel: self.note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")").customNotesText()
							Text("Tire PSI: \(noteModel.rTirePressure, specifier: "%.1f")").customNotesText()
						}
					}
					Spacer()
					
					VStack{
						if self.note.bike?.rearSetup?.dualCompression == true {
							HStack {
								Text("HSC: \(noteModel.rHSCSetting)").customNotesText()
								Text("LSC: \(noteModel.rHSCSetting)").customNotesText()
								}
							} else {
								Text("Compression: \(noteModel.rCompSetting)").customNotesText()
						}
					}
					Spacer()
					
					VStack {
						if self.note.bike?.rearSetup?.dualRebound == true {
							HStack{
								Text("HSR: \(noteModel.rHSRSetting)").customNotesText()
								Text("LSR: \(noteModel.rHSRSetting)").customNotesText()
							}
						} else {
							Text("Rebound: \(noteModel.rReboundSetting)").customNotesText()
						}
					}
				}
			}
		}
		
		.font(.subheadline)
		}
    }
}


