//
//  RearNoteDetailsView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct RearNoteDetailsView: View {
    var body: some View {
        Text("Rear Details")
		
		/*
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
		Text("Spring: \(self.note.rAirSpring, specifier: "%.0f")").customNotesText()
		
		if self.note.bike?.rearSetup?.isCoil == false {
		Text("Tokens: \(self.note.rTokens)").customNotesText()
		}
		}
		}
		Spacer()
		
		VStack{
		HStack {
		Text("Sag %: \(calcSag(sag: Double(self.note.rSag), travel: self.note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")").customNotesText()
		Text("Tire PSI: \(self.note.rTirePressure, specifier: "%.1f")").customNotesText()
		}
		}
		Spacer()
		
		VStack{
		if self.note.bike?.rearSetup?.dualCompression == true {
		HStack {
		Text("HSC: \(self.note.rHSC)").customNotesText()
		Text("LSC: \(self.note.rLSC)").customNotesText()
		}
		} else {
		Text("Compression: \(self.note.rCompression)").customNotesText()
		}
		}
		Spacer()
		
		VStack {
		if self.note.bike?.rearSetup?.dualRebound == true {
		HStack{
		Text("HSR: \(self.note.rHSR)").customNotesText()
		Text("LSR: \(self.note.rLSR)").customNotesText()
		}
		} else {
		Text("Rebound: \(self.note.rRebound)").customNotesText()
		}
		}
		}
		}
		}
		
		.font(.subheadline)
		}
		
		*/
    }
}


