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
        GeometryReader { geometry in
            VStack {
                Text(self.note.date != nil ? "\(self.note.date!, formatter: self.dateFormatter)" : "")
                Text(self.note.bike?.name ?? "Unknown bike")
                    .font(.title)
                Text(self.note.note ?? "No note")
                    .foregroundColor(.secondary)
                RatingView(rating: .constant(Int(self.note.rating)))
                    .font(.subheadline)
                Divider()
                

            }
        }
        .navigationBarTitle(Text(note.bike?.name ?? "Unknown Note"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Note"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteNote()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    
    
    func deleteNote() {
        moc.delete(note)

        // uncomment this line if you want to make the deletion permanent
         try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)


    static var previews: some View {
        let note = Notes(context: moc)
        note.date = Date()
        note.bike?.name = "Test RideNote"
        note.note = "Some Note Text"
        note.rating = 4

        return NavigationView {
            NotesDetailView(note: note)
        }
    }
}
