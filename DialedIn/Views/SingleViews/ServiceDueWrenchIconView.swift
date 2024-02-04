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
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.red)
            .customTextShadow()
            .frame(width: 40, height: 40)
            .padding(.horizontal, 15)
            .customTextShadow()
    }
}


struct ServiceDueWrenchIconView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDueWrenchIconView()
    }
}
