//
//  PersistentCloudKitContainer.swift
//  DialedIn
//
//  Created by Jason Hilimire on 11/25/20.
//

import CoreData
public class PersistentCloudKitContainer {
    
        // MARK: - Define Constants / Variables
        public static var context: NSManagedObjectContext {
                return persistentContainer.viewContext
        }
    
        // MARK: - Initializer
        private init() {}
    
        // MARK: - Core Data stack
        public static var persistentContainer: NSPersistentCloudKitContainer = {
			let container = NSPersistentCloudKitContainer(name: "DialedIn")
			container.loadPersistentStores(completionHandler: { (storeDescription, error) in
					if let error = error as NSError? {
							fatalError("Unresolved error \(error), \(error.userInfo)")
					}
			})
			container.viewContext.automaticallyMergesChangesFromParent = true
			container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
			return container
        }()
    
        // MARK: - Core Data Saving support
        public static func saveContext () {
			let context = persistentContainer.viewContext
			if context.hasChanges {
				do {
					try context.save()
				} catch {
					let nserror = error as NSError
					fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
				}
			}
        }
}
