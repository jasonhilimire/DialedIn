//
//  OnBoardingView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct OnBoardingView: View {
	
	@AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
	@State var buttonText = "Let's Go!"
	
	
    var body: some View {
		ZStack {
			VStack{
				HStack {
					Image("bicycle-fork")
						.resizable()
						.scaledToFit()
						.frame(width: 65, height: 65)
						.padding(.horizontal, 10)
					Text("Dialed In")
						.font(.largeTitle)
						.fontWeight(.heavy)
						.customShadow()
						.foregroundColor(.white)
					Image("shock-absorber")
						.resizable()
						.scaledToFit()
						.frame(width: 65, height: 65)
						.padding(.horizontal, 10)
				}
				.padding()
				VStack (alignment: .leading) {
					HStack {
						Image("bike")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
	//						.padding(.horizontal, 10)
						Text("Create a bike - add your fork & shock setup info")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.customTextShadow()
					.padding()
					HStack {
						Image(systemName: "square.and.pencil")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
	//						.padding(.horizontal, 10)
						Text("Add a note for you current settings")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.customTextShadow()
					.padding()
					HStack {
						Image(systemName: "note.text.badge.plus")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
	//						.padding(.horizontal, 10)
						Text("Add/Favorite your notes as you update your settings to get yourself 'DialedIn!' ")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.customTextShadow()
					.padding()
				}
				Spacer()
				HStack {
					Button(action: {
						// DISMISS ONBOARD VIEW
						needsAppOnboarding = false
						withAnimation(.linear(duration: 0.05), {
							self.buttonText = "     SHRED ON!!     "
						})
						hapticSuccess()
						
					}) {
						SaveButtonView(buttonText: $buttonText)
					}.buttonStyle(OrangeButtonStyle())
				}
				.padding()
				
			}
			Spacer()
			
		}
		.frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color.gray)
		
		

    }
	
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
