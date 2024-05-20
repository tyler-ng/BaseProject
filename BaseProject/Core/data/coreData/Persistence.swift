//
//  Persistence.swift
//  BaseProject
//
//  Created by Tyler on 2024-05-19.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unsolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    static func save() {
        let context = PersistenceController.shared.container.viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            fatalError("""
                \(#file), \
                \(#function), \
                \(error.localizedDescription)
            """)
        }
    }
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PetSave")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
