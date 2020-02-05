//
//  AddDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData

struct NotesDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         return formatter
     }
    
    let note: Notes
    var body: some View {
        VStack {
            Button(action: {
                //dismisses the sheet
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
//                    Text("Button")
                    Spacer()
                    Image(systemName: "xmark.circle")
                }
                .padding(.horizontal)
                .foregroundColor(Color.gray)
            }
            Spacer()
            Text("Detail View")
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)


    static var previews: some View {
        let note = Notes(context: moc)

        return NavigationView {
            NotesDetailView(note: note)
        }
    }
}
