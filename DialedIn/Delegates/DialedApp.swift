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
        }
    }
}
