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
    
    
    var body: some View {
        VStack {
            Text("Add Note View")
            Button(action: {
            //dismisses the sheet
             self.presentationMode.wrappedValue.dismiss()
                            // set all the vars to Bike entity
            //                    try? self.moc.save()
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
