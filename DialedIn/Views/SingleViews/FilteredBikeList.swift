//
//  FilteredBikeList.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct FilteredBikeList: View {
    
    var fetchRequest: FetchRequest<Bike>
    @ObservedObject var model = NoteModel()
    
    @State private var fAirVolume = 45.0
    @State private var fHSC = Int()
    @State private var fLSC = Int()
    @State private var fComp = Int()
    @State private var fCompressionToggle = true
    @State private var fHSR = Int()
    @State private var fLSR = Int()
    @State private var fReb = Int()
    @State private var fReboundToggle = true
    @State private var fTokens = Int()
       
       init(filter: String) {
           fetchRequest = FetchRequest<Bike>(entity: Bike.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS %@", filter))
       }

    var body: some View {
        let bike = fetchRequest.wrappedValue[0]
         return
            Text("\(bike.name ?? "No bike found")")
        
        // Front Setup views
        if bike.frontSetup?.dualCompression == true {
            Stepper(value: $fHSC, in: 0...25, label: {Text("High Sp Comp: \(self.fHSC)")})
            Stepper(value: $fLSC, in: 0...25, label: {Text("Low Sp Comp: \(self.fLSC)")})
         } else {
             Stepper(value: $fComp, in: 0...20, label: {Text("Compression: \(self.fComp)")})
         }
        
        if bike.frontSetup?.dualRebound == true {
            
        } else {
            
        }
        
        // RearSetup
        
        if bike.rearSetup?.isCoil == true {
            
        } else {
            
        }
        
        if bike.rearSetup?.dualCompression == true {
            
        } else {
            
        }
        
        if bike.rearSetup?.dualRebound == true {
            
        } else {
            Text("No Rear Suspension on this Rig")
        }
    }
}

struct FilteredBikeList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredBikeList(filter: "Unknown Bike")
    }
}
