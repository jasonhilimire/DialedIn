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
					.customTextShadow()
					.background(Color("BackgroundColor"))
					.cornerRadius(8)
					.padding(.horizontal, 10)
				Text("Please Create a Bike!")
					.foregroundColor(Color("TextColor"))
					.font(.largeTitle)
					.fontWeight(.thin)
					.customTextShadow()
			}
		}
}

struct CreateBikeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBikeView()
    }
}
