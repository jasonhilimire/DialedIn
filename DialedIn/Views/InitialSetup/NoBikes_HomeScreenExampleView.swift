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
	@State var activeSheet: ActiveSheet?
	
	var trailingBarItems: some View {
		Menu {
			Button(action: { showingAlert.toggle()}) {
				Label("Add New Note", systemImage: "note.text.badge.plus")
			}
			Button(action: {showingAlert.toggle() }) {
				Label("Add New Service", systemImage: "wrench")
			}
			Button(action: {activeSheet = .addBike }) {
				Label("Add New Bike", systemImage: "bicycle")
			}
		} label: {
			Image(systemName: "plus.circle")
				.font(.system(size: 35))
		}
	}
	
	enum ActiveSheet: Identifiable {
		case addNote, addService, addBike
		var id: Int {
			hashValue
		}
	}
	
	// MARK: - BODY -
    var body: some View {
		GeometryReader { geo in
			ZStack {
				VStack{
					ZStack {
						NoBikes_NoteExampleView()
							
							.frame(height: geo.size.height / 2.5 )
					}
					

					NoBikes_ServiceExampleView()
						.frame(width: .infinity, height: geo.size.height / 2.3 )
				}
				.padding()
				.navigationBarTitle("Dialed In")
				.navigationBarItems(trailing: trailingBarItems)
			} //: END Main ZSTACK
			.alert(isPresented: $showingAlert) {
				Alert(title: Text("Please Create a Bike"), message: Text("\(alertText)"), primaryButton: .default(Text("OK")) {
					//
				}, secondaryButton: .cancel())
			}
		}
		
		.sheet(item: $activeSheet) { item in
			switch item {
				case .addNote:
					AddNoteView()
				case .addService:
					ServiceView(bike: nil)
				case .addBike:
					AddBikeView()
			}
		}
	}
}

struct NoBikes_HomeScreenExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_HomeScreenExampleView()
    }
}
