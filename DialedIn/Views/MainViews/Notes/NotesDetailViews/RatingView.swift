//
//  RatingView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = "Ride Rating:"
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
	var offColor = Color.gray
    var onColor = Color.orange

    var body: some View {
        HStack {
            Text(label)
				.fontWeight(.thin)
            ForEach(1..<maximumRating + 1, id: \.self) {number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor: self.onColor)
                    .onTapGesture {
                        self.rating = number
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct HomeRatingView: View {
	@Binding var rating: Int

	var maximumRating = 5
	var offImage: Image?
	var onImage = Image(systemName: "star.fill")
	
	var offColor = Color.gray
	var onColor = Color.white
	
	var body: some View {
		HStack {
			ForEach(1..<maximumRating + 1, id: \.self) {number in
				self.image(for: number)
					.foregroundColor(number > self.rating ? self.offColor: self.onColor)
			}
		}
	}
	
	func image(for number: Int) -> Image {
		if number > rating {
			return offImage ?? onImage
		} else {
			return onImage
		}
	}
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
