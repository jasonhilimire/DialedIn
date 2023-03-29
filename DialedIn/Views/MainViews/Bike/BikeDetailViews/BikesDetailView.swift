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
    
    @State var isFromBikeCard = true
    @State var isShowingService = false
    @State var isShowingEdit = false
    @State var deleteImage = "trash"
    @State var showingDeleteAlert = false
    @State var isShowingAddNote = false
    var deleteText = """
    Are you sure?
    - this will delete all related notes -
    """
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                Text("Note: \(self.bike.bikeNote ?? "")" )
                    .font(.subheadline)
                    .customTextShadow()
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(5)
                VStack {
                    Section {
                        ForkLastServicedView(bike: self.bike)
                    }
                    Divider()
                    Section {
                        if self.bike.hasRearShock == false {
                            Text("HardTail")
                        } else {
                            RearShockLastServicedView(bike: self.bike)
                        }
                    }
                    Divider()
                } //: END VSTACK
                .customBackgroundGradient()
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }//: END VSTACK
            .padding(5)
            Spacer(minLength:10)
            FilteredBikeNotesView(filter: self.bike.name ?? "")
                .padding(.horizontal)
        }//: END VSTACK
        
        .navigationBarTitle(Text(self.bike.name ?? "Unknown Note"), displayMode: .large)
        .navigationBarItems(
            trailing:
                Button(action: {self.showingDeleteAlert.toggle()
                   }) {
                       CircularButtonView(symbolImage: $deleteImage)
                   })
                   .padding(5)
                   .customTextShadow()

        .background(EmptyView().sheet(isPresented: $isShowingService) {
            AddServiceView(isFromBikeCard: $isFromBikeCard, bike: self.bike)
        })
        .background(EmptyView().sheet(isPresented: $isShowingAddNote) {
            AddNoteView(isFromBikeCard: $isFromBikeCard, bike: self.bike)
        })
        .background(EmptyView().sheet(isPresented: $isShowingEdit) {
            EditBikeDetailView(bike: self.bike)
        })
        // Show the Alert to delete the Bike
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Bike"), message: Text("\(deleteText)"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBike()
            }, secondaryButton: .cancel())
        }
        
        HStack {
            Button(action: { isShowingEdit.toggle()}) {
                Label("Edit Bike", systemImage: "square.and.pencil").scaleEffect(1.5)
            }
                .buttonStyle(Nav_Button())
            Spacer()
            Button(action: { isShowingService.toggle()}) {
                Label("Add Service", systemImage: "wrench").scaleEffect(1.5)
            }
                .buttonStyle(Nav_Button())
            Spacer()

            Button(action: { isShowingAddNote.toggle()}) {
                Label("Add Note", systemImage: "note.text.badge.plus").scaleEffect(1.5)
            }
                .buttonStyle(Nav_Button())
            
            
        } //: END HSTACK
        .padding(10)

        .customTextShadow()
    }

    func deleteBike() {
        moc.delete(self.bike)
        try? self.moc.save()
        hapticSuccess()
    }

}






