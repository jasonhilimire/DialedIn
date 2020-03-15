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
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let bike: Bike
    var body: some View {
		VStack{
			GeometryReader { geometry in
				VStack {
					Text(self.bike.name ?? "Unknown Bike")
						.font(.largeTitle)
						.fontWeight(.bold)
					Text("Info: \(self.bike.bikeNote ?? "")" )
						.font(.subheadline)
					VStack {
						Section {
							Text("Fork:")
								.font(.headline)
								.offset(x: -80)
							ForkLastServicedView(fork: self.bike.frontSetup!)
						}
						Divider()
						Section{
							Text("Rear:")
								.font(.headline)
								.offset(x: -80)
							if self.bike.hasRearShock == false {
								Text("HardTail")
							} else {
								RearShockLastServicedView(rear: self.bike.rearSetup!)
							}
						}
					}
					.frame(width: 235, height: 170)
					.foregroundColor(Color.white)
					.background(RoundedRectangle(cornerRadius: 10))
					.foregroundColor(Color.blue)
						
					
					
					HStack(alignment: .bottom) {
						Button(action: {self.doStuff()}) {
							HStack {
								Image(systemName: "square.and.pencil")
								Text("Add Note")
							}
						}
						.sheet(isPresented: self.$showingNotesView)  {
							AddNoteBikeView(front: self.front, rear: self.rear, bike: self.bike).environment(\.managedObjectContext, self.moc)
						}
						Spacer()
						Button(action: {print("Service pressed")}) {
							HStack {
								Image(systemName:"wrench")
								Text("Service")
							}
						}
					}
					
				}
			}
			Divider()
		}
		.frame(height: 280)
		.padding(.horizontal, 15)
		.padding(.top, 1)
		.foregroundColor(Color.blue)
		.background(RoundedRectangle(cornerRadius: 0))
		.foregroundColor(Color.clear)
//			.shadow(radius: 8)
		//
		
		

    }
	
	func doStuff() {
		self.showingNotesView.toggle()
	}
}

//struct BikeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        bike.name = "Test Bike"
//
//        return NavigationView {
//            BikeDetailView(bike: bike)
//        }
//    }
//}

