//
//  InfoView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/5/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import SwiftUI
struct HomePageNotesInfoView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Notes.notesFetchRequest())
    var notes: FetchedResults<Notes>
    
    @FetchRequest(fetchRequest: Notes.favoritedNotesFetchRequest(filter: true))
    var fav_notes: FetchedResults<Notes>
    
    @State private var searchText = ""
    @State private var pickerChoiceIndex = 0
    @State private var pickerChoiceIndex1 = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if notes.count == 0 {
                    Text("0")
                        .font(.largeTitle)
                        .bold()
                    Text("Notes")
                        .fontWeight(.thin)
                } else {
                    NavigationLink(destination: NotesListView(pickerChoiceIndex: $pickerChoiceIndex, searchText: $searchText))
                    {
                        Text("\(notes.count)")
                            .font(.largeTitle)
                            .bold()
                        if notes.count == 1 {
                            Text("Note")
                                .fontWeight(.thin)
                        } else {
                            Text("Notes")
                                .fontWeight(.thin)
                        }
                    }
                    .padding()
//                    .background(
//                        Capsule().strokeBorder(Color.gray, lineWidth: 0.75)
//                    )
                    .customShadow()
                }
            }
                .foregroundColor(Color("TextColor"))
            Spacer()
            HStack {
                if fav_notes.count >= 1 {
                    NavigationLink(destination: NotesListView(pickerChoiceIndex: $pickerChoiceIndex1, searchText: $searchText)) {
                        Text("\(fav_notes.count)")
                            .font(.largeTitle)
                            .bold()
                        Text("Favorites")
                            .fontWeight(.thin)
                    }
                    .padding()
//                    .background(
//                        Capsule().strokeBorder(Color.gray, lineWidth: 0.75)
//                    )
                }
            }
                .foregroundColor(Color("TextColor"))
            Spacer()
            NavigationLink("See All Notes") {
                NotesListView(pickerChoiceIndex: $pickerChoiceIndex, searchText: $searchText)
            }
            .font(.footnote)
            .foregroundColor(Color.gray)
            .padding()
//            .background(
//                Capsule().strokeBorder(Color.gray, lineWidth: 0.50)
//            )
        }
        .padding(20)
        .foregroundColor(Color.white)
        .background(Color.clear)
        .cornerRadius(20)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageNotesInfoView()
    }
}
