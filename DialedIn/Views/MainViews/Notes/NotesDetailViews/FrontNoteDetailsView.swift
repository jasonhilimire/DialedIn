//
//  FrontNoteDetailsView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FrontNoteDetailsView: View {
	@ObservedObject var noteModel = EditNoteViewModel()
	
	let note: Notes
	
    var body: some View {
		
		//TODO: FrontSetup in its own viewModel

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
						Text("Fork PSI: \(noteModel.fAirVolume, specifier: "%.1f")").customNotesText()
						Text("Tokens: \(self.note.fTokens)").customNotesText()
						}
					}
					Spacer()
				VStack{
					HStack{
						Text("Sag %: \(calcSag(sag: Double(noteModel.fSagSetting), travel: self.note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")").customNotesText()
						Text("Tire PSI: \(noteModel.fTirePressure, specifier: "%.1f")").customNotesText()
						}
					}
					Spacer()
				VStack{
						if self.note.bike?.frontSetup?.dualCompression == true {
					HStack {
						Text("HSC: \(noteModel.fHSCSetting)").customNotesText()
						Text("LSC: \(noteModel.fLSCSetting)").customNotesText()
						}
					} else {
						Text("Compression: \(noteModel.fCompSetting)").customNotesText()
						}
					}
				Spacer()
		
				VStack {
						if self.note.bike?.frontSetup?.dualCompression == true {
					HStack{
						Text("HSR: \(noteModel.fHSRSetting)").customNotesText()
						Text("LSR \(noteModel.fHSCSetting)").customNotesText()
						}
					} else {
						Text("Rebound: \(noteModel.fReboundSetting)").customNotesText()
					}
				}
			}
			.font(.subheadline)
		}
    }
}



