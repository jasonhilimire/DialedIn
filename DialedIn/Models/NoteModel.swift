//
//  NoteModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NoteModel: ObservableObject {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        getLastAirSetting()
    }
    
    @Published var lastAirSetting: Int = 0 {
        didSet {
            didChange.send(self)
        }
    }
    
    let didChange = PassthroughSubject<NoteModel, Never>()

    private var lastAir: Int  {
        let notes = try! managedObjectContext.fetch(Notes.fetchRequest()) as! [Notes]
        if let lastRecord = notes.last {
            let lastRecordNote = lastRecord.value(forKey: "stageNum")
                   return lastRecordNote as! Int
               } else {
                   print("didnt find last record")
                   return 55
               }
       }
    
    func getLastAirSetting() {
        lastAirSetting = lastAir
    }
    
}
