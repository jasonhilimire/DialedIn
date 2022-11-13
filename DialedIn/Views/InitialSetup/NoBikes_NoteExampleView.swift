//
//  NoBikes_NoteExampleView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoBikes_NoteExampleView: View {
    var body: some View {
		ZStack {
			VStack {
				Text("Last Note:")
					.font(.title)
					.bold()
					.customTextShadow()
				HStack {
					Text("Example Bike")
					Spacer()
					Text("\(Date(), formatter: dateFormatter)")
					
				}
				.customShadow()
				Spacer()
				
				VStack(alignment: .leading) {
					HStack {
						VStack(alignment: .leading) {
							HomeRatingView(rating: .constant(Int(4)))
							Text("Example- will be replaced when you add your 1st note")
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
							Text("75")
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
						
						HStack {
							Text("R")
							Text("180")
						}
						.lineLimit(1)
						.padding([.top, .bottom, .trailing])
						.font(.body)
					}
					// TODO: the width shouldnt be fixed, but if you have 5 characters its being truncated
					.frame(width: 110, alignment: .leading)
					.customShadow()
					
					Spacer()
					VStack(alignment: .leading) {
						Text("HSC: 6")
						Text("LSC: 7")
						Text("Tokens: 2")
						Divider()
						Text("HSC: 9")
						Text("LSC: 7")
					}.font(.caption)
					
					Spacer()
					VStack(alignment: .leading) {
						Text("HSR: 8")
						Text("LSR: 7")
						Text("Sag %: 25")
						Divider()
						Text("HSR: 12")
						Text("LSR: 13")
						Text("Sag %: 33")
					}.font(.caption)
				} // end HSTack Settings
			} //: END VSTACK
			.padding()
			.foregroundColor(Color.white)
            .customBackgroundGradient()
			.cornerRadius(20)
			// Shadow for left & Bottom
			.customShadow()
		} //: END ZSTACK
    }
}

struct NoBikes_NoteExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_NoteExampleView()
    }
}
