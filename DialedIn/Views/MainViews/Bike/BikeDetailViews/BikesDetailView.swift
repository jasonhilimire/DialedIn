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
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    isShowingService.toggle()
                }) {
                    CircularButtonView(symbolImage: $wrenchImage)
                }
                
                Spacer()
                Text(bike.name ?? "")
                    .fontWeight(.bold)
                    .customTextShadow()
                    .foregroundColor(Color.gray)
                Spacer()
                
                Button(action: {
                    isShowingEdit.toggle()
                    
                }) {
                    CircularButtonView(symbolImage: $symbolImage)
                }
            }
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
        .background(EmptyView().sheet(isPresented: $isShowingService) {
            AddServiceView(isFromBikeCard: $isFromBikeCard, bike: fetchBike(for: bike.wrappedBikeName))
                .environment(\.managedObjectContext, self.moc)
        }
        
        .background(EmptyView().sheet(isPresented: $isShowingEdit) {
            EditBikeDetailView(bike: fetchBike(for: bike.wrappedBikeName))
                .environment(\.managedObjectContext, self.moc)
            }))
    
    }
}






