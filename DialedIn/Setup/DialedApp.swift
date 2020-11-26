//
//  DialedApp.swift
//  Dialed
//
//  Created by Jason Hilimire on 11/25/20.
//

import SwiftUI

var shortcutItemToHandle: UIApplicationShortcutItem?
let quickActionSettings = QuickActionSettings()

@main
struct DialedInApp: App {
    let context = PersistentCloudKitContainer.persistentContainer.viewContext
	@Environment(\.scenePhase) var lifeCycle

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext, context)
				// We will use this modifier below to pass along which quick action that was pressed
				.environmentObject(quickActionSettings)
			
			.onChange(of: lifeCycle) { (newLifeCyclePhase) in
				switch newLifeCyclePhase {
					case .active :
						print("App is active")
						guard let name = shortcutItemToHandle?.userInfo?["name"] as? String else { return }
						
						switch name {
							case "addNote":
								print("Add Note is selected")
								quickActionSettings.quickAction = .details(name: name)
							case "search":
								print("Search is selected")
								quickActionSettings.quickAction = .details(name: name)
							case "addService":
								print("Add Service is selected")
								quickActionSettings.quickAction = .details(name: name)
							default:
								print("default ")
						}
						
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
			return ["name" : "addNote" as NSSecureCoding]
		}
		var searchNoteInfo: [String: NSSecureCoding] {
			return ["name" : "search" as NSSecureCoding]
		}
		var addServiceInfo: [String: NSSecureCoding] {
			return ["name" : "addService" as NSSecureCoding]
		}
		
		UIApplication.shared.shortcutItems = [
			UIApplicationShortcutItem(type: "Add Note", localizedTitle: "Add Note", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .compose), userInfo: addNoteInfo),
			UIApplicationShortcutItem(type: "Search Notes", localizedTitle: "Search Notes", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .search), userInfo: searchNoteInfo),
			UIApplicationShortcutItem(type: "Add Service", localizedTitle: "Add Service", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .confirmation), userInfo: addServiceInfo),
		]
	}
	
	class AppDelegate: NSObject, UIApplicationDelegate {
		func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
			if let shortcutItem = options.shortcutItem {
				shortcutItemToHandle = shortcutItem
			}
			
			let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
			sceneConfiguration.delegateClass = CustomSceneDelegate.self
			
			return sceneConfiguration
		}
	}
	
	class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
		func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
			shortcutItemToHandle = shortcutItem
		}
	}
}
