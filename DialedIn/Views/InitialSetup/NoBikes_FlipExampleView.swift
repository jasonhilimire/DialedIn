//
//  NoBikes_FlipExamplView.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/1/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct NoBikes_FlipExampleView: View {
	@Environment(\.presentationMode) var presentationMode
	
	@State var showBack = false
	
	var body: some View {
		let front = NoBikes_BikeCardExampleView()
		let back = NoBikes_ServiceExampleView()
		
		FlipView(front: front, back: back, showBack: $showBack)
	}
}


struct NoBikes_FlipExamplView_Previews: PreviewProvider {
    static var previews: some View {
        NoBikes_FlipExampleView()
    }
}
