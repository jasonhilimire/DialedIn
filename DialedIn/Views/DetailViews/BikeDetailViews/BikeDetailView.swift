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
		VStack {
            Text(self.bike.name ?? "Unknown Bike")
                .font(.largeTitle)
            Text("Info: \(self.bike.bikeNote ?? "")" )
                .font(.subheadline)
			VStack {
				Section(header: Text("Fork")) {
					ForkLastServicedView(fork: self.bike.frontSetup!)
				}
				
				Section(header: Text("Rear")) {
					if self.bike.hasRearShock == false {
						Text("HardTail")
					} else {
						RearShockLastServicedView(rear: self.bike.rearSetup!)
					}
				}
			}
			.padding()
			.foregroundColor(Color.white)
			.background(RoundedRectangle(cornerRadius: 10))
			.foregroundColor(.green)
			.padding()
		
			HStack(alignment: .bottom) {
				Button(action: {self.doStuff()}) {
					Text("Add Note")
				}
				.sheet(isPresented: $showingNotesView)  {
					AddNoteBikeView(front: self.front, rear: self.rear, bike: self.bike).environment(\.managedObjectContext, self.moc)
				}
//				Spacer()
				Button(action: {print("Service pressed")}) {
					Text("Service")
				}
			}
		
        }
		.padding(.horizontal, 25)
		.background(RoundedRectangle(cornerRadius: 10)
		.stroke(Color.green, lineWidth: 3))
//		.shadow(radius: 20)

    }
	
	func doStuff() {
		self.showingNotesView.toggle()
//		print(bike)
//		print(bike.frontSetup)
//		print(bike.rearSetup)
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

