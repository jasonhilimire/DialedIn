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
    @State var isShowingAllNotes = false
    @State var allNoteCount = 0
    @State var favNoteCount = 0
    @State var allText = "All Notes"
    @State var favText = "Favorites"
    @State var bikeName = ""
    @State var allNotes = 0
    @State var favorites = 1
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

            HStack{
                NavigationLink(destination: NotesListView(pickerChoiceIndex: $allNotes, searchText: $bikeName)) {
                    FilteredNoteButton(buttonText: $allText, noteCount: $allNoteCount)
                        .padding(5)
                        .customTextShadow()
                }

//                Spacer()
                NavigationLink(destination: NotesListView(pickerChoiceIndex: $favorites, searchText: $bikeName)) {
                    FilteredNoteButton(buttonText: $favText, noteCount: $favNoteCount)
                        .padding(5)
                        .customTextShadow()
                }
            }
            Spacer()
            FilteredBikeNotesView(filter: self.bike.name ?? "")
                .padding(.horizontal)
        }//: END VSTACK
        
        .navigationBarTitle(Text(self.bike.name ?? "Unknown Note"), displayMode: .large)
        .navigationBarItems(
            trailing:
                Button(action: {self.showingDeleteAlert.toggle()
                   }) {
                       Image(systemName: "trash")
                   })

        .background(EmptyView().sheet(isPresented: $isShowingService) {
            AddServiceView(isFromBikeCard: $isFromBikeCard, bike: self.bike)
        })
        .background(EmptyView().sheet(isPresented: $isShowingAddNote) {
            AddNoteView(isFromBikeCard: $isFromBikeCard, bike: self.bike)
        })
        .background(EmptyView().sheet(isPresented: $isShowingEdit) {
            EditBikeDetailView(bike: self.bike)
        })
        .background(EmptyView().sheet(isPresented: $isShowingAllNotes) {
            NotesListView(pickerChoiceIndex: $allNotes, searchText: $bikeName)
        })
        // Show the Alert to delete the Bike
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Bike"), message: Text("\(deleteText)"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBike()
            }, secondaryButton: .cancel())
        }
        .onAppear(perform: {self.setup()})
        
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
    
    func setup() {
        bikeName = self.bike.wrappedBikeName
        allNoteCount = self.bike.notesArray.count
        favNoteCount = getFavCount(filter: bikeName)
    }
    
    func getFavCount(filter:String) -> Int {
        let notes = try! moc.fetch(Notes.favoritesByBikeFetchRequest(filter: bikeName))
        return notes.count
    }

}






