//
//  LevelsProvider.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/18/17.
//
//

import Foundation

class LevelsProvider {
    
    /**
     Returns all levels from data base
     
     - Returns: An array of all levels
     */
    static func getLevels() -> [Level]? {
        let dataStack = CoreDataStack.sharedStack
        var levels = [Level]()
        let request = Level.fetchRequest()
        do {
            let count = try dataStack.managedContext.count(for: request)
            if count == 0 {
               addDefaultLevels()
            }
            levels = try dataStack.managedContext.fetch(request)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return levels
    }
    
    /**
     Adds default levels to data base
     
    */
    static func addDefaultLevels() {
        addLevelWith(name: "starter",
                     order: 1,
                     sceneWidth: 10,
                     sceneHeight: 5,
                     sceneMatrix: "###########--#--#--##---&----##-*--%---###########")
    }
    
    /**
     Inserts a new level to data base
     
     - Parameter name: name of level
     - Parameter order: order of level
     - Parameter sceneWidth: A width of level scene
     - Parameter sceneHeight: A height of level scene
     - Parameter sceneMatrix: A matrix of level scene consistently recorded in string
     */
    static func addLevelWith( name: String,
                              order: NSNumber,
                              sceneWidth: NSNumber,
                              sceneHeight: NSNumber,
                              sceneMatrix: String) {
        
        let dataStack = CoreDataStack.sharedStack
        let level = Level(context: dataStack.managedContext)
        level.name = name
        level.order = order
        let scene = Scene(context: dataStack.managedContext)
        scene.height = sceneHeight
        scene.width = sceneWidth
        scene.matrix = sceneMatrix
        level.scene = scene
        dataStack.saveContext()
    }
}
