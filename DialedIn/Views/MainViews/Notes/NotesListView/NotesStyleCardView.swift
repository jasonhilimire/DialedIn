//
//  NotesStyleCardView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/3/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NotesStyleCardView: View {
	// MARK: - PROPERTIES -
	
	@ObservedObject var note: Notes
	
	// MARK: - BODY
    var body: some View {
		ZStack {
			VStack {
				HStack {
					Text(note.bike?.name ?? "Unknown Bike")
						.fontWeight(.thin)
					Spacer()
					Text(note.date != nil ? "\(note.date!, formatter: dateFormatter)" : "")
						.fontWeight(.thin)
					if note.isFavorite == true {
						FavoritesView(favorite: .constant(note.isFavorite))
					} else {
						Text("   ")
					}
				}
				Spacer()
				
				VStack(alignment: .leading) {
					HStack {
						VStack(alignment: .leading) {
							if note.rating > 0 {
								RatingView(rating: .constant(Int(note.rating)))
							}
							Text(note.note ?? "")
								.fontWeight(.thin)
						}
						.font(.footnote)
						Spacer()
					}
				}
				
				Divider()
				
				HStack {
					VStack {
						HStack {
							Text("F")
								.fontWeight(.thin)
							Text("\(note.fAirVolume, specifier: "%.1f")")
								.fontWeight(.thin)
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
						
						
						HStack {
							Text("R")
								.fontWeight(.thin)
							Text("\(note.rAirSpring, specifier: "%.0f")")
								.fontWeight(.thin)
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
					}
					// TODO: the width shouldnt be fixed, but if you have 5 characters its being truncated
					.frame(width: 110, alignment: .leading)
					
					Spacer()
					VStack(alignment: .leading) {
						if note.bike?.frontSetup?.dualRebound == true {
							Text("HSR: \(note.fHSR)").fontWeight(.thin)
							Text("LSR: \(note.fLSR)").fontWeight(.thin)
						} else {
							Text("Reb: \(note.fRebound)").fontWeight(.thin)
							
						}
						Text("Sag %: \(calcSag(sag: Double(note.fSag), travel: note.bike?.frontSetup?.travel ?? 0.0), specifier: "%.1f")").fontWeight(.thin)
						Divider()
						if note.bike?.rearSetup?.dualRebound == true {
							Text("HSR: \(note.rHSR)").fontWeight(.thin)
							Text("LSR: \(note.rLSR)").fontWeight(.thin)
						} else {
							Text("Reb: \(note.rRebound)").fontWeight(.thin)
						}
						Text("Sag %: \(calcSag(sag: Double(note.rSag), travel: note.bike?.rearSetup?.strokeLength ?? 0.0), specifier: "%.1f")").fontWeight(.thin)
					}.font(.caption)
					
					Spacer()
					VStack(alignment: .leading) {
						if note.bike?.frontSetup?.dualCompression == true {
							Text("HSC: \(note.fHSC)").fontWeight(.thin)
							Text("LSC: \(note.fLSC)").fontWeight(.thin)
						} else {
							Text("Comp: \(note.fCompression)").fontWeight(.thin)
						}
						Text("Tokens: \(note.fTokens)").fontWeight(.thin)
						Divider()
						if note.bike?.rearSetup?.dualCompression == true {
							Text("HSC: \(note.rHSC)").fontWeight(.thin)
							Text("LSC: \(note.rLSC)").fontWeight(.thin)
						} else {
							Text("Comp: \(note.rCompression)").fontWeight(.thin)
						}
						if note.bike?.rearSetup?.isCoil == false {
							Text("Tokens: \(note.rTokens)").fontWeight(.thin)
						} else {
							Text("").fontWeight(.thin)
						}
					}.font(.caption)
				} // end HSTack Settings
			}
			.padding()
			.foregroundColor(Color("TextColor"))
			.background(Color("BackgroundColor"))
			.cornerRadius(4.0)
			// Shadow for left & Bottom
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
			//shadow for right & top
			//				.shadow(color: Color("ShadowColor"), radius: 5, x: 5, y: -5)
		}
    }
}
