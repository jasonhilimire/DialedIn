//
//  ContentView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/26/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import CoreData



struct NotesListView: View {
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(fetchRequest: Bike.bikesFetchRequest())
    var bikes: FetchedResults<Bike>

    @ObservedObject var bike = BikeModel()
    
    
    @State private var showingActionSheet = false
    var buttonsArray: NSMutableArray  = NSMutableArray()
    var names = [String]()
    
    
    init() {
        names = getBikeNames()
        loadArray()
        
    }
    
    var body: some View {

        NavigationView {
            List{
                NoteCellView()
            }
            .navigationBarTitle("DialedIn")
                .navigationBarItems(leading: EditButton(), trailing:
                Button(action: { self.showingActionSheet.toggle()
                }) {
                    //TODO: DISABLE BUTTON IF BIKE.COUNT IS EMPTY
                    Image(systemName: "gauge.badge.plus")
            })
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Bikes").bold()
                        , message: Text("Choose a bike"), buttons: buttonsArray as! [ActionSheet.Button])
            }
            
            
//                .sheet(isPresented: $showingAddScreen)  {
//                    AddNoteView().environment(\.managedObjectContext, self.moc)
//            }
        }
    }
        
    func getBikeNames() -> [String] {
        return bike.allBikeNames()
    }

    
    func loadArray() {
        for bike in 0..<names.count {
            let button: ActionSheet.Button =
                .default(Text("\(self.names[bike])"), action: {
                    print("\(self.names[bike])")
//                    AddNoteView(bike: self.names)
                })
            self.buttonsArray[bike] = button
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
