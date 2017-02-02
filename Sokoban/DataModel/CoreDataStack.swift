//
//  CoreDataStack.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/20/17.
//
//

import UIKit
import CoreData

class CoreDataStack {
    
    static let sharedStack = CoreDataStack()
    
    private lazy var storeContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Sokoban")
        container.loadPersistentStores {
            (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext : NSManagedObjectContext = {
        let mangedContext = self.storeContainer.viewContext
        mangedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return mangedContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do  {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
