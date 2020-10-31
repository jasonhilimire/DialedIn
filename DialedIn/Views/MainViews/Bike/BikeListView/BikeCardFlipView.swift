//
//  BikeCardFlipView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 10/31/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeCardFlipView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	
	@State var showBack = false
	
	let bike: Bike
	
    var body: some View {
		let front = BikeCardView(bike: bike)
		let back = BikeDetailCardView(bike: bike)
				
		FlipView(front: front, back: back, showBack: $showBack)
	}
}



struct FlipView<SomeTypeOfViewA : View, SomeTypeOfViewB : View> : View {
	
	var front : SomeTypeOfViewA
	var back : SomeTypeOfViewB
	
	@State private var flipped = false
	@Binding var showBack : Bool
	
	var body: some View {
		
		return VStack {
			Spacer()
			
			ZStack() {
				front.opacity(flipped ? 0.0 : 1.0)
				back.opacity(flipped ? 1.0 : 0.0)
			}
			.modifier(FlipEffect(flipped: $flipped, angle: showBack ? 180 : 0, axis: (x: 0, y: 1)))
			.onTapGesture {
				withAnimation(Animation.linear(duration: 0.8)) {
					self.showBack.toggle()
				}
			}
			Spacer()
		}
	}
}

struct FlipEffect: GeometryEffect {
	
	var animatableData: Double {
		get { angle }
		set { angle = newValue }
	}
	
	@Binding var flipped: Bool
	var angle: Double
	let axis: (x: CGFloat, y: CGFloat)
	
	func effectValue(size: CGSize) -> ProjectionTransform {
		
		DispatchQueue.main.async {
			self.flipped = self.angle >= 90 && self.angle < 270
		}
		
		let tweakedAngle = flipped ? -180 + angle : angle
		let a = CGFloat(Angle(degrees: tweakedAngle).radians)
		
		var transform3d = CATransform3DIdentity;
		transform3d.m34 = -1/max(size.width, size.height)
		
		transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
		transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
		
		let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
		
		return ProjectionTransform(transform3d).concatenating(affineTransform)
	}
}



