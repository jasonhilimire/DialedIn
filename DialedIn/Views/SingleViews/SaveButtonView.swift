//
//  SaveButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 1/30/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

// TODO: Change this to a buttonstyle
struct SaveButtonView: View {
    var body: some View {
         HStack {
               Image(systemName: "checkmark.circle")
               Text("Save")
           }
               .multilineTextAlignment(.center)
               .padding().frame(maxWidth: 300)
               .foregroundColor(Color.white)
               .background(Color.green)
               .cornerRadius(8)
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView()
    }
}
