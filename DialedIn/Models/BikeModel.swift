//
//  BikeModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/9/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BikeModel: ObservableObject {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    init() {
        getBikes()
    }
    
    @Published var bikeNames = [String]() {
        didSet {
            didChange.send(self)
        }
    }
    
    
    let didChange = PassthroughSubject<BikeModel, Never>()

    func allBikeNames() -> [String]  {
        var bikeNames = [String]()
        let bikes = try! managedObjectContext.fetch(Bike.fetchRequest()) as! [Bike]
        for index in 0..<bikes.count {
            if let bikeName = bikes[index].name {
                bikeNames.append(bikeName)
            }
        }
        print(bikeNames)
        return bikeNames
       }
    
    
    func getBikes() {
        bikeNames = allBikeNames()
    }
    
}

