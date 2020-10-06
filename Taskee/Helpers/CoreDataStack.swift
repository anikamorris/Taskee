//
//  CoreDataStack.swift
//  Taskee
//
//  Created by Anika Morris on 10/3/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import CoreData //import the core data module

class CoreDataStack {

    private let modelName: String //create a private property to store the modelName

    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    init(modelName: String) {
        self.modelName = modelName //initializer needed to save the modelName into the private property
    }

    //lazy instantiate the NSPersistentContainer, passing the modelName
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores {(storeDescription, error) in
            if let error = error as NSError? {
            print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext () {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
