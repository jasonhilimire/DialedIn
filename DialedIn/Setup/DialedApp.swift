//
//  DialedApp.swift
//  Dialed
//
//  Created by Jason Hilimire on 11/25/20.
//

import SwiftUI

@main
struct DialedInApp: App {
    let context = PersistentCloudKitContainer.persistentContainer.viewContext
	@Environment(\.scenePhase) var lifeCycle

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, context)
			
			.onChange(of: lifeCycle) { (newLifeCyclePhase) in
				switch newLifeCyclePhase {
					case .active :
						print("App is active")
					case .inactive:
						print("App is inactive")
					case .background:
						print("App is going to the Background")
						// This will add our dynamic quick actions when our app is sent to the background on our device
						addQuickActions()
					@unknown default:
						print("default")
				}
			}
			
			
        }
    }
	
	func addQuickActions() {
		var addNoteInfo: [String: NSSecureCoding] {
			return ["name" : "Add Note" as NSSecureCoding]
		}
		var searchNoteInfo: [String: NSSecureCoding] {
			return ["name" : "Search" as NSSecureCoding]
		}
		var addServiceInfo: [String: NSSecureCoding] {
			return ["name" : "Add Service" as NSSecureCoding]
		}
		
		UIApplication.shared.shortcutItems = [
			UIApplicationShortcutItem(type: "Add Note", localizedTitle: "Add Note", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .compose), userInfo: addNoteInfo),
			UIApplicationShortcutItem(type: "Search Notes", localizedTitle: "Search Notes", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .search), userInfo: searchNoteInfo),
			UIApplicationShortcutItem(type: "Add Service", localizedTitle: "Add Service", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .confirmation), userInfo: addServiceInfo),
		]
	}
}
