//
//  ForkDetailView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/19/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ForkDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    let fork: Fork
    var body: some View {
        VStack {
        Text(self.fork.lowerLastServiced != nil ? "Lowers last serviced: \(self.fork.lowerLastServiced!, formatter: self.dateFormatter)" : "Unknown")
        Text(self.fork.lasfFullService != nil ? "Last full service: \(self.fork.lasfFullService!, formatter: self.dateFormatter)" : "Unknown")
        }
        
    }
}

//struct ForkDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForkDetailView()
//    }
//}
