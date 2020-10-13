//
//  BikeCardView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/29/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct BikeCardView: View {
// MARK: - PROPERTIES -
	@Environment(\.managedObjectContext) var moc
	
	@State private var isAnimating: Bool = false
	@State var buttonText = "View"
	@State var showingDeleteAlert = false
	var deleteText = """
	Are you sure?
	- this will delete all related notes -
	"""

	let bike: Bike
	
// MARK: - BODY -
    var body: some View {
			ZStack {
				VStack{
					// DELETE BUTTON??? HERE OR ON THE DETAIL VIEW??
					HStack {
						Spacer()
						
						Button(action: {
							self.showingDeleteAlert.toggle()
						}) {
							DeleteButtonView()
						}
						
					}
					.padding(8)
					
					// BIKE: IMAGE - change these images here so it shows a full suspension or hardtail depending on bike type
					Image("bike")
						.resizable()
						.scaledToFit()
						.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
						.scaleEffect(isAnimating ? 1.0 : 0.6)
						.padding(.horizontal, 10)
					
					// BIKE: NAME
					Text(self.bike.name ?? "Unknown")
						.foregroundColor(Color.white)
						.font(.largeTitle)
						.fontWeight(.heavy)
						.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
					
					// BIKE: DETAILS
					Text(self.bike.bikeNote ?? "")
						.foregroundColor(Color.white)
						.multilineTextAlignment(.center)
						.padding(.horizontal, 16)
						.frame(maxWidth: 480)
					
//					// BUTTON:
					NavigationLink(destination: BikeDetailView(bike: bike)) {
						ArrowButtonView(buttonText: $buttonText)
					}
					
				} //: VSTACK
				.padding(.bottom, 16)
			} //: ZSTACK
			.onAppear{
				withAnimation(.easeOut(duration: 0.5)) {
					isAnimating = true
				}
			}
//			.frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
			.background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red
			]) , startPoint: .top, endPoint: .bottom)))
			.cornerRadius(20)
			.padding(.horizontal, 20)
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
			// Show the Alert to delete the Bike
			.alert(isPresented: $showingDeleteAlert) {
				Alert(title: Text("Delete Bike"), message: Text("\(deleteText)"), primaryButton: .destructive(Text("Delete")) {
					self.deleteBike()
				}, secondaryButton: .cancel()
				)
			}
		
	}
	
	
	func deleteBike() {
		moc.delete(bike)
		try? self.moc.save()
		hapticSuccess()
	}
}



// MARK: - PREVIEW -
//struct BikeCardView_Previews: PreviewProvider {
//    static var previews: some View {
//		BikeCardView(bike: )
//			.previewLayout(.fixed(width: 320, height: 640))
//    }
//}