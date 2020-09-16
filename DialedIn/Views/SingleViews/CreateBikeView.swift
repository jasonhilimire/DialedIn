//
//  CreateBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/15/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct CreateBikeView: View {
    var body: some View {
			VStack{
				Image("bike")
					.resizable()
					.scaledToFit()
					.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
					.background(Color("BackgroundColor"))
					.cornerRadius(8)
					.padding(.horizontal, 10)
				Text("Please Create a Bike!")
					.foregroundColor(Color("TextColor"))
					.font(.largeTitle)
					.fontWeight(.thin)
					.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
			}
		}
}

struct CreateBikeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBikeView()
    }
}
