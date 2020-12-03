//
//  NoteModel.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/28/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class NoteModel: ObservableObject {
	
	let managedObjectContext = PersistentCloudKitContainer.persistentContainer.viewContext
	
	// MARK: - Published Variables
	
	let didChange = PassthroughSubject<NoteModel, Never>()
	
	@Published var noteText: String = "" {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteRating: Int16 = 1 {
		didSet {
			didChange.send(self)
		}
	}
	
	@Published var noteFavorite: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	

	
	func getNoteModel(note: Notes) {
		noteText = note.note ?? ""
		noteRating = note.rating
		noteFavorite = note.isFavorite
	}
	
}
