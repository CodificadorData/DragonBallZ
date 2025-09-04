//
//  CoreDataStack.swift
//  AppPapple
//
//  Created by Christian Morante on 25/08/25.
//

import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()
    
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyAppDataBase")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error cargando Core Data: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error al guardar contexto: \(error)")
            }
        }
    }
}
