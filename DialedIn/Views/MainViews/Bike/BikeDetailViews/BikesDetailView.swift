//
//  BikesDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/12/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//
import SwiftUI
import CoreData
import Combine

struct BikesDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let bike: Bike
    
    @State var wrenchImage = "wrench"
    @State var symbolImage = "square.and.pencil"
    @State var isFromBikeCard = true
    @State var isShowingService = false
    @State var isShowingEdit = false
    @State var deleteImage = "trash"
    @State var showingDeleteAlert = false
     var deleteText = """
    Are you sure?
    - this will delete all related notes -
    """
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    isShowingService.toggle()
                }) {
                    CircularButtonView(symbolImage: $wrenchImage)
                }
                Spacer()
                //TODO: MOVE THIS TO ANOTHER?
                Button(action: {
                    self.showingDeleteAlert.toggle()
                    
                }) {
                    CircularButtonView(symbolImage: $deleteImage)
                }
            .padding(8)
            .customTextShadow()
                
                Spacer()
                Button(action: {
                    isShowingEdit.toggle()
                }) {
                    CircularButtonView(symbolImage: $symbolImage)
                }
            } //: END HSTACK
            .padding(8)
            .customTextShadow()
            VStack {
                Text("Note: \(self.bike.bikeNote ?? "")" )
                    .font(.subheadline)
                    .customTextShadow()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(2)
                VStack {
                    Section {
                        ForkLastServicedView(bike: self.bike)
                    }
                    Divider()
                    Section{
                        if self.bike.hasRearShock == false {
                            Text("HardTail")
                        } else {
                            RearShockLastServicedView(bike: self.bike)
                        }
                    }
                    Divider()
                } //: END VSTACK
            }//: END VSTACK
            Spacer(minLength:5)
            FilteredBikeNotesView(filter: self.bike.name ?? "")
                .padding(.horizontal)
        }//: END VSTACK
        .navigationBarTitle(Text(self.bike.name ?? "Unknown Note"), displayMode: .inline)
        .background(EmptyView().sheet(isPresented: $isShowingService) {
            AddServiceView(isFromBikeCard: $isFromBikeCard, bike: self.bike)
        }
        .background(EmptyView().sheet(isPresented: $isShowingEdit) {
            EditBikeDetailView(bike: self.bike)
            }))
        // Show the Alert to delete the Bike
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Bike"), message: Text("\(deleteText)"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBike()
            }, secondaryButton: .cancel())
        }
    }

    func deleteBike() {
        moc.delete(self.bike)
        try? self.moc.save()
        hapticSuccess()
    }

}






