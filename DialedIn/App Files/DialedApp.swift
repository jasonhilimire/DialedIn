//
//  DialedApp.swift
//  Dialed
//
//  Created by Jason Hilimire on 11/25/20.
//

import SwiftUI

@main
struct DialedInApp: App {
	@StateObject private var boolModel = BoolModel()
	
    let context = PersistentCloudKitContainer.persistentContainer.viewContext
	
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context)
				.environmentObject(boolModel)
				.onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}


// FIXES Keyboard issues
extension UIApplication {
	func addTapGestureRecognizer() {
		guard let window = windows.first else { return }
		let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
		tapGesture.requiresExclusiveTouchType = false
		tapGesture.cancelsTouchesInView = false
		tapGesture.delegate = self
		window.addGestureRecognizer(tapGesture)
	}
}

extension UIApplication: UIGestureRecognizerDelegate {
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return false // set to `false` if you don't want to detect tap during other gestures
	}
}
