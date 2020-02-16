//
//  AddFrontSetupView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/12/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct AddFrontSetupView: View {
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    // Get All the bikes for the PickerView
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest())
    var bikes: FetchedResults<Bike>
    
    @ObservedObject var model = NoteFrontSetupModel()
    
    @State var bikeNameIndex = 0
    
    var body: some View {
        
        
        
        return
            Text("")
        
//        // Front Setup views
//        if bike. == true {
//            Stepper(value: $fHSC, in: 0...25, label: {Text("High Sp Comp: \(self.fHSC)")})
//            Stepper(value: $fLSC, in: 0...25, label: {Text("Low Sp Comp: \(self.fLSC)")})
//         } else {
//             Stepper(value: $fComp, in: 0...20, label: {Text("Compression: \(self.fComp)")})
//         }
//        
//        if bike.frontSetup?.dualRebound == true {
//            
//        } else {
//            
//        }
    }
}

struct AddFrontSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AddFrontSetupView()
    }
}
