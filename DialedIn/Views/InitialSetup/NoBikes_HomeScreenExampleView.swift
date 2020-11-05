//
//  NoBikes_HomeScreenExampleView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoBikes_HomeScreenExampleView: View {
	// MARK: - PROPERTIES -
	@State private var showingAlert: Bool = false
	private var alertText = "You must create a bike before adding notes or services"
	
	// MARK: - BODY -
    var body: some View {
		GeometryReader { geo in
			ZStack {
				VStack{
					ZStack {
						NoBikes_NoteExampleView()
							
							.frame(height: geo.size.height / 2.5 )
					}
					
					GeometryReader { innergeo in
						HStack {
							Button(action: {
								self.showingAlert.toggle()
							}) {
								HStack {
									Image(systemName: "wrench")
									Text("Add Service")
								}
							}.buttonStyle(GradientButtonStyle())
							.frame(width: innergeo.size.width / 2, height: 15)
							
							Spacer()
							Button(action: {
								self.showingAlert.toggle()
							}) {
								HStack {
									Image(systemName: "gauge.badge.plus")
									Text("Add Note")
								}
							}.buttonStyle(GradientButtonStyle())
							.frame(width: innergeo.size.width / 2, height: 15)
							
						} //: END HSTACK
						.frame(width: .infinity, height: geo.size.height / 9 )
					}
					NoBikes_ServiceExampleView()
						.frame(width: .infinity, height: geo.size.height / 2.3 )
				}
				.padding()
				.navigationBarTitle("Dialed In")
			} //: END Main ZSTACK
			.alert(isPresented: $showingAlert) {
				Alert(title: Text("Please Create a Bike"), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
					//
				}, secondaryButton: .cancel())
			}
		}
	}
}

struct NoBikes_HomeScreenExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_HomeScreenExampleView()
    }
}
