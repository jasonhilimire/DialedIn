//
//  NoBikes_BikeDetailCardExampleView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoBikes_BikeDetailCardExampleView: View {
	
	@State var symbolImage = "square.and.pencil"
	
    var body: some View {
		ZStack {
			VStack{
				HStack {
					Spacer()
						CircularButtonView(symbolImage: $symbolImage)
				}
				.padding(8)
				.customTextShadow()
				
				VStack{
					VStack {
						Text("Note: Tap to flip card back over" )
							.font(.title3)
							.customShadow()
							.fixedSize(horizontal: false, vertical: true)
							.padding(5)
						VStack {
							Section {
								ForkServiceExampleView()
							}
							Divider()
							Section{
								RearServiceExampleView()
							}
						}
					}
					.padding(.bottom, 20)
					
					Text("Last 5 Notes")
						.font(.largeTitle)
						.fontWeight(.bold)
						.customTextShadow()
					Spacer()
					
				}
					.foregroundColor(Color.white)
					.multilineTextAlignment(.center)
					.padding(.bottom, 12)
				
			} //: VSTACK
			.padding(.bottom, 16)
		} //: ZSTACK
		.background(Color.gray)
		.cornerRadius(20)
		.padding(.horizontal, 20)
		.customShadow()

    }
}

struct NoBikes_BikeDetailCardExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_BikeDetailCardExampleView()
    }
}
