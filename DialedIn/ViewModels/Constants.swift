//
//  Constants.swift
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


struct CustomNumberField: UIViewRepresentable {
	@Environment(\.colorScheme) var colorScheme
	@Binding var text: String
	var placeholder: String
	
	func makeUIView(context: UIViewRepresentableContext<CustomNumberField>) -> UITextField {
		let textField = UITextField(frame: .zero)
		textField.delegate = context.coordinator
		textField.font = UIFont(name: "HelveticaNeue", size: 15)
		textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
		textField.borderStyle = .roundedRect // needs to be in place otherwise textfield is small?
//		textField.isScrollEnabled = true
//		textField.isEditable = true
		textField.isUserInteractionEnabled = true
		textField.backgroundColor = UIColor(named: "TextEditBackgroundColor")
		textField.placeholder = placeholder
		textField.keyboardType = .decimalPad
		return textField
	}
	
	func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomNumberField>) {
		uiView.text = text
		uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
		uiView.setContentCompressionResistancePriority(.required, for: .vertical)
	}
	
	func makeCoordinator() -> CustomNumberField.Coordinator {
		Coordinator(parent: self)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		var parent: CustomNumberField
		
		init(parent: CustomNumberField) {
			self.parent = parent
		}
		
		func textFieldDidChangeSelection(_ textField: UITextField) {
			parent.text = textField.text ?? ""
		}
		
		func textViewDidChange(_ textView: UITextView) {
			print("text now: \(String(describing: textView.text!))")
			self.parent.text = textView.text ?? ""
		}
		
	}
}

struct CustomTextField: UIViewRepresentable {
	@Environment(\.colorScheme) var colorScheme
	@Binding var text: String
	var placeholder: String
	
	func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
		let textField = UITextField(frame: .zero)
		textField.delegate = context.coordinator
		textField.font = UIFont(name: "HelveticaNeue", size: 15)
		textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
		textField.borderStyle = .roundedRect // needs to be in place otherwise textfield is small?
		//		textField.isScrollEnabled = true
		//		textField.isEditable = true
		textField.isUserInteractionEnabled = true
		textField.backgroundColor = UIColor(named: "TextEditBackgroundColor")
		textField.placeholder = placeholder
		textField.keyboardType = .alphabet
		return textField
	}
	
	func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
		uiView.text = text
		uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
		uiView.setContentCompressionResistancePriority(.required, for: .vertical)
	}
	
	func makeCoordinator() -> CustomTextField.Coordinator {
		Coordinator(parent: self)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		var parent: CustomTextField
		
		init(parent: CustomTextField) {
			self.parent = parent
		}
		
		func textFieldDidChangeSelection(_ textField: UITextField) {
			parent.text = textField.text ?? ""
		}
		
		func textViewDidChange(_ textView: UITextView) {
			print("text now: \(String(describing: textView.text!))")
			self.parent.text = textView.text ?? ""
		}
		
	}
}

// tapGesture that dismisses the keyboard
var tap: some Gesture {
	TapGesture(count: 1)
		.onEnded { _ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
}

// calculate sag

func calcSag(sag: Double, travel: Double) -> Double {
	let calculatedTravel = (sag / travel) * 100.0
	
	return calculatedTravel
}

// haptic vibration for Save button
func hapticSuccess() {
	let generator = UINotificationFeedbackGenerator()
	generator.notificationOccurred(.success)
}


// CustomNotes Text Modifier & extension to utilize
struct CustNotesText: ViewModifier {
	// system font, size 16 and thin
	let font = Font.system(size: 16).weight(.thin)
	
	func body(content: Content) -> some View {
		content
			.foregroundColor(Color("TextColor"))
			.font(font)
			.fixedSize()
	}
}

struct ShadowModifier: ViewModifier {
	// this shadow is disabled in dark mode
	func body(content: Content) -> some View {
		content
			.shadow(color: Color("ShadowColor"), radius: 5, x: -5, y: 5)
	}
}


struct CardShadowModifier: ViewModifier {
	// this shadow Modifies Text on Cards
	func body(content: Content) -> some View {
		content
			.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
	}
}

struct FootnoteBoldTextModifier: ViewModifier {
	// system font, size footnote and bold
	let font = Font.system(.footnote).weight(.bold)
	
	func body(content: Content) -> some View {
		content
			.font(font)
	}
}


extension View {
	func customNotesText() -> some View {
		return self.modifier(CustNotesText())
	}
	
	func customShadow() -> some View {
		return self.modifier(ShadowModifier())
	}
	
	func customTextShadow() -> some View {
		return self.modifier(CardShadowModifier())
	}
	
	func customFootnoteBold() -> some View {
		return self.modifier(FootnoteBoldTextModifier())
	}
}

// Calculates Days between service
func daysBetween(start: Date, end: Date) -> Int {
	return Calendar.current.dateComponents([.day], from: start, to: end).day!
}

// Performs a fetch request for selected Bike and returns it
//TODO: Create this using bike ID??
func fetchBike(for bikeName: String) -> Bike {
	let moc = PersistentCloudKitContainer.persistentContainer.viewContext
	var bikes : [Bike] = []
	let fetchRequest = Bike.selectedBikeFetchRequest(filter: bikeName)
	do {
		bikes = try moc.fetch(fetchRequest)
	} catch let error as NSError {
		print("Could not fetch. \(error), \(error.userInfo)")
	}
	let bike = bikes[0]
	return bike
}

// alllows if else conditional on view modifiers
extension View {
	@ViewBuilder
	func `if`<TrueContent: View, FalseContent: View>(
		_ condition: Bool,
		if ifTransform: (Self) -> TrueContent,
		else elseTransform: (Self) -> FalseContent
	) -> some View {
		if condition {
			ifTransform(self)
		} else {
			elseTransform(self)
		}
	}
}

// Operator overload - fixes Cannot convert value of type 'Binding<String?>' to expected argument type 'Binding<String>'

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
	Binding(
		get: { lhs.wrappedValue ?? rhs },
		set: { lhs.wrappedValue = $0 }
	)
}