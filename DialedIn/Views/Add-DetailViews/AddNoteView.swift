//
//  AddNoteView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/27/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddNoteView: View {
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: Bike.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Bike.name, ascending: true)
    ]) var bikes: FetchedResults<Bike>
    
    @State private var bikeName = ""
    @State private var note = ""
    
    
    var body: some View {
        VStack{
            VStack{
                Picker(selection: $bikeName, label: Text("Choose Bike")) {
                ForEach(bikes, id: \.self) { bike in Text(bike.wrappedBikeName).tag(bike.wrappedBikeName)}
                        }
                TextField("Note", text: $note )
                }
            
            Button(action: {
                //dismisses the sheet
                 self.presentationMode.wrappedValue.dismiss()
                
                let newNote = Notes(context: self.moc)
                newNote.note = self.note
                newNote.bike = Bike(context: self.moc)
                newNote.bike?.name = self.bikeName
                
                try? self.moc.save()
            }) {
                SaveButtonView()
                }
        }
        
        

    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
