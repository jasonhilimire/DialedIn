//
//  ServiceDueWrenchIconView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/12/22.
//  Copyright © 2022 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ServiceDueWrenchIconView: View {
    var body: some View {
        Image("wrench.and.screwdriver.fill")
            .foregroundColor(.red)
            .scaledToFit()
            .customTextShadow()
            .frame(width: 25, height: 25, alignment: .center)
            .padding(.horizontal, 10)
            .customTextShadow()
    }
}

struct ServiceDueWrenchIconView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDueWrenchIconView()
    }
}
