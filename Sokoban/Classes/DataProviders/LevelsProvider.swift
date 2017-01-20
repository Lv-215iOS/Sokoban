//
//  LevelsProvider.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//
/*
 first level example
 
 ##########
 #--#--#--#
 #---&----#
 #-*--%---#
 ##########
 
 */

import Foundation

class LevelsProvider {
    ///returns all level
    static func getLevels() -> [Level]? {
        let dataStack = CoreDataStack.sharedStack
        var levels = [Level]()
        let request = NSFetchRequest<Level>(entityName: "Level")
        do {
            let count = try dataStack.managedContext.count(for: request)
            if count == 0 {
               addLevel()
            }
            levels = try dataStack.managedContext.fetch(request)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return levels
    }
    /// add first level
    private static func addLevel() {
        let dataStack = CoreDataStack.sharedStack
        let level = Level(context: dataStack.managedContext)
        level.name = "starter"
        level.order = 1
        let scene = Scene(context: dataStack.managedContext)
        scene.height = 5
        scene.width = 10
        scene.matrix = "###########--#--#--##---&----##-*--%---###########"
        level.scene = scene
        dataStack.saveContext()
    }
}
