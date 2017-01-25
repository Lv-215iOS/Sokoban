//
//  LevelsProvider.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//
/*
 Level 1
 
 ##########
 #--#--#--#
 #---&----#
 #-*--%---#
 ##########
 
 Level 2
 
 ########
 #--#---#
 #---*--#
 #--#**-#
 ##-#---#
 #%%-*#-#
 #%%---&#
 ########
 
 
 */

import Foundation

class LevelsProvider {
    
    ///returns all levels
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
    
    /// adds default levels
    static func addDefaultLevels() {
        addLevelWith(name: "Level 1",
                     order: 1,
                     sceneWidth: 10,
                     sceneHeight: 5,
                     sceneMatrix: "###########--#--#--##---&----##-*--%---###########")
        addLevelWith(name: "Level 2",
                     order: 2,
                     sceneWidth: 8,
                     sceneHeight: 8,
                     sceneMatrix: "#########--#---##---*--##--#**-###-#---##%%-*#-##%%---&#########")
    }
    
    /// adds level
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
