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
import MessageUI



var dateFormatter: DateFormatter {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	return formatter
}


//// tapGesture that dismisses the keyboard
//var tap: some Gesture {
//	TapGesture(count: 1)
//		.onEnded { _ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
//}

// calculate sag

func calcSag(sag: Double, travel: Double) -> Double {
	let calculatedTravel = (sag / travel) * 100.0
	return calculatedTravel
}

func calcSagString(sag: Double, travel: Double) -> String {
    let sagCalc = calcSag(sag: sag, travel: travel)
    if !(1...100).contains(sagCalc) {
        return "Sag %: N/A"
    } else {
        return "Sag %: \(sagCalc.rounded())"
    }
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


struct CustTextField: ViewModifier {
	// system font, size 16 and thin
	let font = Font.body.weight(.thin)
	
	func body(content: Content) -> some View {
		content
			.foregroundColor(Color("TextColor"))
			.font(font)
			.padding(7)
			.background(Color(.systemGray6))
			.cornerRadius(8)
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

struct SaveButtonModifier: ViewModifier {
	// adds horizontal and bottom padding when button is shown above keyboard outside the form
	func body(content: Content) -> some View {
		content
			.padding(.horizontal)
			.padding(.bottom, 8)
			.animation(.default)
	}
}

struct BackGroundGradientModifier: ViewModifier {
    // adds horizontal and bottom padding when button is shown above keyboard outside the form
    func body(content: Content) -> some View {
        content
            .background((LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]) , startPoint: .top, endPoint: .bottom)))
    }
}


extension View {
	func customTextField() -> some View {
		return self.modifier(CustTextField())
	}
	
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
	
	func customSaveButton() -> some View {
		return self.modifier(SaveButtonModifier())
	}
    
    func customBackgroundGradient() -> some View {
        return self.modifier(BackGroundGradientModifier())
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

extension Color {
    static var customGradient = (LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red
                                                                           ]) , startPoint: .top, endPoint: .bottom))
}

//Message UI Setup to send as a text message

struct MessageComposeView: UIViewControllerRepresentable {
    typealias Completion = (_ messageSent: Bool) -> Void

    static var canSendText: Bool { MFMessageComposeViewController.canSendText() }
        
    let recipients: [String]?
    let body: String?
    let completion: Completion?
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard Self.canSendText else {
            let errorView = MessagesUnavailableView()
            return UIHostingController(rootView: errorView)
        }
        
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: self.completion)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        private let completion: Completion?

        public init(completion: Completion?) {
            self.completion = completion
        }
        
        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion?(result == .sent)
        }
    }
}

struct MessagesUnavailableView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .font(.system(size: 64))
                .foregroundColor(.red)
            Text("Messages is unavailable")
                .font(.system(size: 24))
        }
    }
}
