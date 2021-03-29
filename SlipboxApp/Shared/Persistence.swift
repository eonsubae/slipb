//
//  Persistence.swift
//  SlipboxPad
//
//  Created by KRITSSEAN on 2021/03/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        
        container = NSPersistentCloudKitContainer(name: "SlipboxApp")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    
    
    //MARK: - Preview helper
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Note(title: "a note", context: viewContext)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    //MARK: - unit test
    /*
     3/30 Section3
     3/31, 4/1 Section4
     4/2, 4/3 Section5
     4/4, 4/5, 4/6 Section6
     4/7, 4/8 Section7
     4/9, 4/10, 4/11 Section8
    */
    static var empty: PersistenceController = {
        return PersistenceController(inMemory: true)
    }()
}
