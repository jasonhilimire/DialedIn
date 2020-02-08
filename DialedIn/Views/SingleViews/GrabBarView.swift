//
//  GrabBarView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 2/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct GrabBarView: View {
    var body: some View {
        VStack {
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("")
            }
            
        }
        .padding().frame(maxWidth: 35, maxHeight: 2.5)
        .background(Color.gray)
        .cornerRadius(8)
    }
}

struct GrabBarView_Previews: PreviewProvider {
    static var previews: some View {
        GrabBarView()
    }
}
