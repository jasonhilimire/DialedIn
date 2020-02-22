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
    @State var buttonsArray: NSMutableArray  = NSMutableArray()
    @State private var names = [String]()
    
    
//    init() {
//        names = getBikeNames()
//        loadArray()
//
//    }
    
    var body: some View {

        NavigationView {
            List{
                NoteCellView()
                  
            }
                .onAppear(perform: {self.reload()})
                .onReceive(bike.didChange, perform: {_ in self.reload()})
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
    
    func reload() {
        getBikeNames()
        self.names = getBikeNames()
        loadArray()
        print("Reload: \(names)")
        

    }
        
    func getBikeNames() -> [String] {
        print("getBikeNames: \(bike.allBikeNames())")
        return bike.allBikeNames()
    }

    
    func loadArray() {
// TODO: THIS works but removing a bike does not update the buttons array?
        print("loadArray: \(names)")
        for bike in 0..<names.count {
            let button: ActionSheet.Button =
                .default(Text("\(self.names[bike])"), action: {
                    print("\(self.names[bike])")
//                    AddNoteView(bike: self.names)
                })
            print("bike in\(self.names[bike])")
            self.buttonsArray[bike] = button
            print("Load array ran")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
