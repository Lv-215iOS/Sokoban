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
    
    static let coreDataStack = CoreDataStack()
    
    private init() {}
    
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
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do  {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")		
        }
    }
    
}
