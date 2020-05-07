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




