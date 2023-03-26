//
//  FrontNoteDetailsView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FrontNoteDetailsView: View {
	@ObservedObject var noteVM = NoteViewModel()
	
	let note: Notes
	
    var body: some View {
		Group {
			VStack {
				VStack {
					HStack {
						Image("bicycle-fork")
						.resizable()
						.frame(width: 50, height: 50)
						.scaledToFit()
						Text("\(self.note.bike?.frontSetup?.info ?? "Fork Details")")
						.font(.headline)
						.fontWeight(.thin)
						.fixedSize()
						}
					}
					Spacer()
		
				VStack {
					HStack {
						Text("Fork PSI: \(noteVM.fAirVolume, specifier: "%.1f")").customNotesText()
						Text("Tokens: \(self.note.fTokens)").customNotesText()
						}
                    if self.note.bike?.frontSetup?.dualAir == true {
                        Text("Secondary PSI: \(noteVM.fAirVolume2, specifier: "%.1f")").customNotesText()
                        }
					}
					Spacer()
				VStack{
					HStack{
						Text("Sag %: \(calcSag(sag: Double(noteVM.fSagSetting), travel: self.note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")").customNotesText()
						Text("Tire PSI: \(noteVM.fTirePressure, specifier: "%.1f")").customNotesText()
						}
					}
					Spacer()
				VStack{
						if self.note.bike?.frontSetup?.dualCompression == true {
					HStack {
						Text("HSC: \(noteVM.fHSCSetting)").customNotesText()
						Text("LSC: \(noteVM.fLSCSetting)").customNotesText()
						}
					} else {
						Text("Compression: \(noteVM.fCompSetting)").customNotesText()
						}
					}
				Spacer()
		
				VStack {
						if self.note.bike?.frontSetup?.dualCompression == true {
					HStack{
						Text("HSR: \(noteVM.fHSRSetting)").customNotesText()
						Text("LSR \(noteVM.fHSCSetting)").customNotesText()
						}
					} else {
						Text("Rebound: \(noteVM.fReboundSetting)").customNotesText()
					}
				}
			}
			.font(.subheadline)
		}
    }
}



