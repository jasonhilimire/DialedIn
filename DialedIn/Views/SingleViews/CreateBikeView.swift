//
//  CreateBikeView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/15/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI


struct CreateBikeView: View {
    @Binding var createText: String
    var body: some View {
			VStack{
				Image("bike")
					.resizable()
					.scaledToFit()
					.customTextShadow()
					.cornerRadius(8)
					.padding(.horizontal, 10)
				Text(createText)
					.foregroundColor(Color("TextColor"))
					.font(.largeTitle)
					.fontWeight(.thin)
					.customTextShadow()
			}
		}
}

