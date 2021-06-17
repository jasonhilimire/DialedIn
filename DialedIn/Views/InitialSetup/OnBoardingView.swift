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
				
				// MARK: - START NOTES -
				VStack (alignment: .leading) {
					HStack {
						Image(systemName: "bicycle")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
							.foregroundColor(.yellow)
							.padding(.horizontal, 10)
						Text("Create a bike - add your fork & shock setup info")
							.font(.subheadline)
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
							.foregroundColor(.purple)
							.padding(.horizontal, 10)
						Text("Add a note to record your current settings and info")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.customTextShadow()
					.padding()
					
					HStack {
						Image(systemName: "dial.max.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
							.foregroundColor(.green)
							.padding(.horizontal, 10)
						Text("When you create a new note- your last settings are restored- no more re-counting clicks!")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundColor(.white)
							.lineLimit(3)
					}
					.customTextShadow()
					.padding()
					HStack {
						Image(systemName: "bookmark.circle.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
							.foregroundColor(.orange)
							.padding(.horizontal, 10)
						Text("Favorite your notes for quick view of your most Dialed In settings")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.customTextShadow()
					.padding()
					HStack {
						Image(systemName: "wrench.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
							.foregroundColor(.red)
							.padding(.horizontal, 10)
						Text("Maintain & check if service is overdue")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
//					.customTextShadow()
					.padding()
					
					HStack {
						Image(systemName: "house.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
							.foregroundColor(.white)
							.padding(.horizontal, 10)
						Text("Easy access to your last note & all your bikes")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
//					.customTextShadow()
					.padding()
					
					HStack {
						Image(systemName: "checkmark.icloud.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 55, height: 55)
							.foregroundColor(.blue)
							.padding(.horizontal, 10)
						Text("Sync notes using iCloud between your devices")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					//					.customTextShadow()
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
				.padding(.bottom, 30)
				
			}
			Spacer()
			
		}
		.frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color.black)
		
		

    }
	
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
