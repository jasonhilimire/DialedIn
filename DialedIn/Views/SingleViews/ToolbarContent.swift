//
//  ToolbarContent.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/24/21.
//  Copyright © 2021 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct SheetToolBar: ToolbarContent{
//	var confirmAction: () -> Void
	var cancelAction: () -> Void
//	var destructAction: () -> Void
	
    var body: some ToolbarContent {
//		ToolbarItem(placement: .destructiveAction) {
//			Button(action: {
//				destructAction()
//			}, label: {
//				Image(systemName: "trash.circle")
//			})
//		}
		
//		ToolbarItem(placement: .confirmationAction) {
//			Button(action: {
//				confirmAction()
//			}, label: {
//				Image(systemName: "checkmark.circle")
//			})
//		}
		
		ToolbarItem(placement: .cancellationAction) {
			Button(action: {
				cancelAction()
			}, label: {
				Image(systemName: "xmark.circle").foregroundColor(.red)
			})
		}
    }
}


