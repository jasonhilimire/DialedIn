//
//  HomeTabView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 6/10/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
	@State var dragAmount = CGSize.zero
	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 0) {
				ForEach(1..<10) { num in
					VStack {
						GeometryReader { geo in
							Text("Number \(num)")
								.font(.largeTitle)
								.padding()
								.background(Color.red)
								.rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 8), axis: (x: 0, y: 1, z: 0))
						}
					}
					.frame(width: 180)
				}
			}
			.padding()
		}
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
