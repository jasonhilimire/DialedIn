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
            //TODO: Make this a button that jsut changes views when removing tab bar : https://blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-observableobject/
            NavigationLink("See All Notes") {
                NotesListView()
            }
            
        }
        .padding()
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
