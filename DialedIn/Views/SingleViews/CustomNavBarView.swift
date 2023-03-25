//
//  CustomNavBarView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/25/23.
//  Copyright © 2023 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct CustomNavBarView: View {
    var body: some View {
        HStack{
            Image("bicycle-fork")
                .resizable()
                .frame(width: 25, height: 25)
                .scaledToFit()
            Text("Dialed In")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
            Image("shock-absorber")
                .resizable()
                .frame(width: 25, height: 25)
                .scaledToFit()
        }.padding(5)
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarView()
    }
}
