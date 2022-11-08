//
//  InfoView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/5/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import SwiftUI
struct InfoView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Notes.notesFetchRequest())
    var notes: FetchedResults<Notes>
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if notes.count == 0 {
                    Text("0")
                        .font(.largeTitle)
                        .bold()
                    Text("Notes")
                } else {
                    Text("\(notes.count)")
                        .font(.largeTitle)
                        .bold()
                    if notes.count == 1 {
                        Text("Note")
                    } else {
                        Text("Notes")
                    }
                }
            }
            .foregroundColor(Color("TextColor"))
            Spacer()
            NavigationLink("See All Notes") {
                NotesListView()
            }
            .font(.footnote)
            .foregroundColor(Color.gray)

        }
        .padding(20)
        .foregroundColor(Color.white)
        .background(Color.clear)
        .cornerRadius(20)
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(Color.gray, lineWidth: 2))
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
