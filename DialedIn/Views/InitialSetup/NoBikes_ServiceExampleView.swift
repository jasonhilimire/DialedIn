//
//  NoBikes_ServiceExampleView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoBikes_ServiceExampleView: View {
    var body: some View {
		VStack {
			Text("Example Bike")
				.fontWeight(.heavy)
				.customTextShadow()
			Text("Info: Please Create your first bike!" )
				.font(.subheadline)
				.fontWeight(.thin)
			
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
		.frame(width: 300, height: 250)
		.foregroundColor(Color("TextColor"))
		.background(Color("BackgroundColor"))
		.cornerRadius(20)
		.overlay(
			RoundedRectangle(cornerRadius: 20)
				.stroke(Color.orange, lineWidth: 2))
		.customShadow()
	}
}

struct ForkServiceExampleView: View {
	var body: some View {
		VStack(alignment: .leading) { // Fork Section
			HStack {
				Image("bicycle-fork")
					.resizable()
					.frame(width: 25, height: 25)
					.scaledToFit()
				Text("Sick Shock - 165mm")
					.font(.headline)
					.fontWeight(.semibold)
				Spacer()
				
				//				Text("\(self.bike.frontSetup?.info ?? "")")
			}
			.padding([.top, .leading, .trailing])
			.customShadow()
			
			HStack(alignment: .center) {
				Text("Lowers Last Serviced:")
					.fontWeight(.light)
				Spacer()
				Text( "\(Date(), formatter: dateFormatter)")
					.fontWeight(.light)
				
			}
			.padding(.horizontal)
			.font(.footnote)
			
			HStack {
				Text("Last Full Service:")
					.fontWeight(.light)
				Spacer()
				Text("\(Date(), formatter: dateFormatter)")
					.fontWeight(.light)
			}
			.padding(.horizontal)
			.font(.footnote)
		}
	}
}

struct RearServiceExampleView: View {
	var body: some View {
		VStack (alignment: .leading) { // Rear Section
			HStack {
				Image("shock-absorber")
					.resizable()
					.frame(width: 25, height: 25)
					.scaledToFit()
				Text("Boingy Bits, stroke: 52.5mm")
					.font(.headline)
					.fontWeight(.semibold)
			}
			.padding(.horizontal)
			.customShadow()
			
			HStack {
				Text("Last Air Can Service:")
					.fontWeight(.light)
				Spacer()
				Text("\(Date(), formatter: dateFormatter)")
					.fontWeight(.light)
			}
			.padding(.horizontal)
			.font(.footnote)
			
			HStack {
				Text("Last Full Service:")
					.fontWeight(.light)
				Spacer()
				Text("\(Date(), formatter: dateFormatter)")
					.fontWeight(.light)
			}
			.padding(.horizontal)
			.font(.footnote)
		}
	}
}

struct NoBikes_ServiceExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_ServiceExampleView()
    }
}
