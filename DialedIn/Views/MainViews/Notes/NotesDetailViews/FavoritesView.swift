//
//  FavoritesView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 4/18/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
	@Binding var favorite: Bool
//	@Binding var isHomeFavorite: Bool
	
	var label = "Favorite Note:"
	var offImage = Image(systemName: "bookmark.circle")
	var onImage = Image(systemName: "bookmark.circle.fill")
	
	var offColor = Color.gray
	var onColor = Color.orange
	var homeColor = Color.white// TODO Refactor this to use a boolean from homeview and get rid of Home Favorites view
	
	var body: some View {
		HStack {
			self.image()
				.imageScale(.large)
				.foregroundColor(self.favorite ? self.onColor: self.offColor)
//				.foregroundColor(self.favorite ? self.isHomeFavorite ? self.homeColor: self.onColor: self.offColor)
				.onTapGesture {
					self.favorite.toggle()
			}
		}
	}
	
	func image() -> Image {
		if favorite == false {
			return offImage
		} else {
			return onImage
		}
	}
}

struct HomeFavoritesView: View {
	@Binding var favorite: Bool

	var offImage = Image(systemName: "bookmark.circle")
	var onImage = Image(systemName: "bookmark.circle.fill")
	
	var offColor = Color.gray
	var onColor = Color.white
	
	var body: some View {
		HStack {
			self.image()
				.imageScale(.large)
				.foregroundColor(self.favorite ? self.onColor: self.offColor)
		}
	}
	
	func image() -> Image {
		if favorite == false {
			return offImage
		} else {
			return onImage
		}
	}
}

