//
//  SearchBarView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/10/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
	@Binding var text: String
	
	@State private var isEditing = false
	
	var body: some View {
		HStack {
			
			TextField("Search ...", text: $text)
				.padding(7)
				.padding(.horizontal, 25)
				.background(Color(.systemGray6))
				.cornerRadius(8)
				.overlay(
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(.gray)
							.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
							.padding(.leading, 8)
						
						if isEditing {
							Button(action: {
								self.text = ""
							}) {
								Image(systemName: "multiply.circle.fill")
									.foregroundColor(.gray)
									.padding(.trailing, 8)
							}
						}
					}
				)
				.onTapGesture {
					self.isEditing = true
				}
			
			if isEditing {
				Button(action: {
					self.isEditing = false
					self.text = ""
					
				}) {
					Text("Cancel")
				}
				.padding(.trailing, 10)
				.transition(.move(edge: .trailing))
				.animation(.default)
			}
		}
	}
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
		SearchBarView(text: .constant(""))
    }
}
