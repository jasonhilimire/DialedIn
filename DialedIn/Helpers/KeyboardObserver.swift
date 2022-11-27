//
//  KeyboardObserver.swift
//  DialedIn
//
//  Created by Jason Hilimire on 5/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class KeyboardObserver: ObservableObject {
	@Published var height: CGFloat = 0
	@Published var keyBoardShown = false
	
	var notificationCenter: NotificationCenter
	
	init(center: NotificationCenter = .default) {
		notificationCenter = center
		notificationCenter.addObserver(
			self,
			selector: #selector(keyBoardWillShow(notification:)),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		notificationCenter.addObserver(
			self,
			selector: #selector(keyBoardWillHide(notification:)),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
	}
	deinit {
		notificationCenter.removeObserver(self)
	}
	
	@objc func keyBoardWillShow(notification: Notification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			height = keyboardSize.height
			keyBoardShown = true
			print("Keyboard shown: \(keyBoardShown)")
		}
	}
	
	@objc func keyBoardWillHide(notification: Notification) {
		height = 0
		keyBoardShown = false
	}
}
