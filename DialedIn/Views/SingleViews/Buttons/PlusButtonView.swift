//
//  PlusButtonView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 12/5/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct PlusButtonView: View {
    var body: some View {
		Image(systemName: "plus.circle")
			.font(.system(size: 30))
			.foregroundColor(Color("TextColor"))
    }
}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView()
    }
}
