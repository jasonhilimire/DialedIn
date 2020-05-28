//
//  Helper.swift
//  DialedIn
//
//  Created by Jason Hilimire on 3/31/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

var dateFormatter: DateFormatter {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	return formatter
}


// Creates a UIKit TextView for editing notes much easier
struct TextView: UIViewRepresentable {
	@Binding var text: String

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	func makeUIView(context: Context) -> UITextView {

		let myTextView = UITextView()
		myTextView.delegate = context.coordinator

		myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
		myTextView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
		myTextView.isScrollEnabled = true
		myTextView.isEditable = true
		myTextView.isUserInteractionEnabled = true
		myTextView.backgroundColor = UIColor(named: "TextEditBackgroundColor")

		return myTextView
	}

	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
	}

	class Coordinator : NSObject, UITextViewDelegate {

		var parent: TextView

		init(_ uiTextView: TextView) {
			self.parent = uiTextView
		}

		func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
			return true
		}

		func textViewDidChange(_ textView: UITextView) {
			print("text now: \(String(describing: textView.text!))")
			self.parent.text = textView.text
		}
	}
}


struct TextNumberView: UIViewRepresentable {
	@Binding var text: String
	var placeholder: String
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIView(context: Context) -> UITextView {
		
		let myTextView = UITextView()
		myTextView.delegate = context.coordinator
		
		myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
		myTextView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
		myTextView.isScrollEnabled = true
		myTextView.isEditable = true
		myTextView.isUserInteractionEnabled = true
		myTextView.backgroundColor = UIColor(named: "TextEditBackgroundColor")
		myTextView.keyboardType = .decimalPad
//		myTextView.returnKeyType = .done
		myTextView.text = placeholder
		
		
		return myTextView
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
		
	}
	
	
	class Coordinator : NSObject, UITextViewDelegate {
		
		var parent: TextNumberView
		
		init(_ uiTextView: TextNumberView) {
			self.parent = uiTextView
		}
		
		func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
			return true
		}
		
		func textViewDidChange(_ textView: UITextView) {
			print("text now: \(String(describing: textView.text!))")
			self.parent.text = textView.text
		}
		
	}
}


struct CustomUIKitTextField: UIViewRepresentable {
	
	@Binding var text: String
	var placeholder: String
	
	func makeUIView(context: UIViewRepresentableContext<CustomUIKitTextField>) -> UITextField {
		let textField = UITextField(frame: .zero)
		textField.delegate = context.coordinator
		textField.placeholder = placeholder
		textField.keyboardType = .decimalPad
		return textField
	}
	
	func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomUIKitTextField>) {
		uiView.text = text
		uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
		uiView.setContentCompressionResistancePriority(.required, for: .vertical)
	}
	
	func makeCoordinator() -> CustomUIKitTextField.Coordinator {
		Coordinator(parent: self)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		var parent: CustomUIKitTextField
		
		init(parent: CustomUIKitTextField) {
			self.parent = parent
		}
		
		func textFieldDidChangeSelection(_ textField: UITextField) {
			parent.text = textField.text ?? ""
		}
		
	}
}


// tapGesture that dismisses the keyboard
var tap: some Gesture {
	TapGesture(count: 1)
		.onEnded { _ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
}




