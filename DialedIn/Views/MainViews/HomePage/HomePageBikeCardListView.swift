//
//  HomeServiceView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 9/24/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

// SHOW THE LAST SERVICES ADDED, based on the last bike note added -  maybe set up for 'default bike' (though need to configure defaults so they are only applicable for one bike
// Fetch the last note.bike.name - then feed that into the views that are already configured
// ensure they dont duplicate -
// could also use side scrollable cards sorted by name for bikes on the bottom list?


struct HomePageBikeCardListView: View {
	//MARK: - PROPERTIES -
	@Environment(\.managedObjectContext) var moc

    @FetchRequest(fetchRequest: Bike.bikesDefaultFirstFetchRequest())
    var bikes: FetchedResults<Bike>
    
    @State private var showingBikeScreen = false
	
	// MARK: - BODY -
	var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(bikes, id: \.self) { bike in
                    NavigationLink(destination: BikesDetailView(bike: bike)){
                        HomePageStyledBikeCardView(bike: bike)
                    }
                }
                .padding(.top, 5)
                .padding(.horizontal, 10)
            }
            .customShadow()
            }
        }
    }




// MARK: - HomeStyledBikeCardView -
struct HomePageStyledBikeCardView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var showScreenBool: BoolModel
	
	@StateObject var bikeVM = BikeViewModel()
    @ObservedObject var frontService = FrontServiceViewModel()
    @ObservedObject var rearService = RearServiceViewModel()
    @ObservedObject var frontVM = NoteFrontSetupViewModel()
    @ObservedObject var rearVM = NoteRearSetupViewModel()
	
	@State private var isFromBikeCard = true
	@State private var showServiceView = false
	@State private var showEditBikeDetailView = false
    @State private var showBikeNotes = false
    @State private var showAddNote = false
	
	let bike: Bike

    @State var buttonText = ""
    @State var rearText = ""
    @State var pickerChoiceIndex = 0
    @State var bikeSearchName = ""
    
    init(bike: Bike){
        self.bike = bike
        frontService.getLastServicedDates(bike: bike.wrappedBikeName)
        rearService.getLastServicedDates(bike: bike.wrappedBikeName)
    }

	var body: some View {
        HStack{
            BikeNameCircle(buttonText: $buttonText)
                .padding()
            VStack(alignment: .leading){
                HStack{
                    Text(self.bike.name ?? "Unknown Bike")
                        .fontWeight(.heavy)
                    Spacer()
                    
                }//: END HSTACK
                HStack{
                    Text("Front -")
                    Text("PSI: \(frontVM.getAirforBikeCard(bike: self.bike.name ?? "N/A"), specifier: "%.1f")")
                }
                if self.bike.frontSetup?.dualAir == true {
                    HStack {
                        Text("Secondary -")
                        Text("PSI: \(frontVM.getAir2forBikeCard(bike: self.bike.name ?? "N/A"), specifier: "%.1f")")
                    }
                }
                
                if self.bike.hasRearShock == true {
                    HStack {
                        Text("Rear  -")

                        Text("\(rearText) \(rearVM.getLastAirForBikeCard(bike: self.bike.name ?? "N/A"), specifier: "%.0f")")
                    }
                }
            }//:END VSTACK
            if serviceDue() {
                ServiceDueWrenchIconView().padding()
            }
                
            Spacer()
        }//: END HSTACK
        .padding(.vertical)
        .onAppear(){
            self.getButtonLetter(bikeName: bike.wrappedBikeName)
            self.setrearText()
        }
		.foregroundColor(Color("TextColor"))
		.background(Color("BackgroundColor"))
		.cornerRadius(20)
        
		.contextMenu {
			VStack {
				Button(action: {
					publishBikeName()
					self.showServiceView.toggle()
				}) {
					HStack {
						Text("Add Service")
						Image(systemName: "wrench")
						}
					}
				Button(action: {
					publishBikeName()
					self.showEditBikeDetailView.toggle()
				}) {
					HStack {
						Text("Edit Bike")
						Image(systemName: "bicycle")
					}
				}
                Button(action: {
                    publishBikeName()
                    self.showBikeNotes.toggle()
                }) {
                    HStack {
                        Text("View Notes")
                        Image(systemName: "note.text")
                        }
                    }
                Button(action: {
                    publishBikeName()
                    self.showAddNote.toggle()
                }) {
                    HStack {
                        Text("Add New Note")
                        Image(systemName: "doc.badge.plus")
                        }
                    }
			}  //: END VSTACK
		} //: END CONTEXT

		// nested background view to show 2 sheets in same view...
		.background(EmptyView().sheet(isPresented: $showServiceView) {
			AddServiceView(isFromBikeCard: $isFromBikeCard, bike: bike)
				.environmentObject(self.showScreenBool)
				.environment(\.managedObjectContext, self.moc)
		})
		.background(EmptyView().sheet(isPresented: $showEditBikeDetailView) {
			EditBikeDetailView(bike: bike)
				.environmentObject(self.showScreenBool)
				.environment(\.managedObjectContext, self.moc)
		})
        .background(EmptyView().sheet(isPresented: $showBikeNotes) {
            NotesListView(pickerChoiceIndex: $pickerChoiceIndex, searchText: $bikeSearchName)
        })
        .background(EmptyView().sheet(isPresented: $showAddNote) {
            AddNoteView(isFromBikeCard: $isFromBikeCard, bike: bike)
        })
    }//: END VIEW
        
	
	func publishBikeName() {
		self.showScreenBool.bikeName = bike.name ?? "Unknown"
        bikeSearchName = bike.name ?? ""
		bikeVM.getBike(for: showScreenBool.bikeName)
	}
    
    func getButtonLetter(bikeName: String){
        buttonText = bikeName.first?.uppercased() ?? "U"
    }
    
    func setrearText() {
        rearText = bike.rearSetup?.isCoil ?? false ? "Coil:" : "PSI:"
    }
    
    func serviceDue() -> Bool {
        if frontService.elapsedLowersServiceWarning || frontService.elapsedFullServiceWarning
            || rearService.elapsedFullServiceWarning || rearService.elapsedAirCanServiceWarning {
            return true
        } else {
            return false
        }
    }
}




