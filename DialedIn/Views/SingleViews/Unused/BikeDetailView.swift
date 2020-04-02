//
//  BikeDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/4/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct BikeDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
	
	@ObservedObject var front = NoteFrontSetupModel()
	@ObservedObject var rear = NoteRearSetupModel()
    
    @State private var showingDeleteAlert = false
	@State private var showingNotesView = false
	@State private var bikeName = ""
	@State var showService = false
	
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let bike: Bike
	
    var body: some View {
		VStack{
				VStack {
					Text(self.bike.name ?? "Unknown Bike")
						.font(.largeTitle)
						.fontWeight(.bold)
					Text("Info: \(self.bike.bikeNote ?? "")" )
						.font(.subheadline)
					VStack {
						Section {
							
							ForkLastServicedView(bike: bike, fork: self.bike.frontSetup!, bikeName: $bikeName)
						}
						Divider()
						Section{
							
							if self.bike.hasRearShock == false {
								Text("HardTail")
							} else {
								RearShockLastServicedView(rear: self.bike.rearSetup!, bike: self.bike)
							}
						}
					}
					
					
//					HStack(alignment: .bottom) {
//						Button(action: {self.doStuff()}) {
//							HStack {
//								Image(systemName: "square.and.pencil")
//								Text("Add Note")
//							}
//						}
//						.sheet(isPresented: self.$showingNotesView)  {
//							AddNoteBikeView(front: self.front, rear: self.rear, bike: self.bike)
//								.environment(\.managedObjectContext, self.moc)
//								.transition(.slide)
//						}
//						Spacer()
						Button(action: {
							withAnimation {
								self.showService.toggle()
							}
						}) {
							HStack {
								
							Image(systemName: "wrench")
								.imageScale(.large)
								.rotationEffect(.degrees(showService ? 90 : 0))
								.scaleEffect(showService ? 1.5 : 1)
								.padding()
								Text("Add Service")
									
							
						}
					}
					
					if showService {
						ServiceView(bike: self.bike)
							.transition(.move(edge: .bottom))
					}
						

						
//					}
					Spacer()
				}

		}
		.padding()

    }
	
	func doStuff() {
		self.showingNotesView.toggle()
	}
}



