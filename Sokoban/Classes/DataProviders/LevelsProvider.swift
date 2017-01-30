//
//  LevelsProvider.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/18/17.
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
 
 #######
 ####--#
 #--#--#
 #-*-*-#
 #-&%%-#
 #-#-###
 #---###
 #######
 
 Level 3
 
 ########
 #---#--#
 #-#-#%*#
 #----%*#
 #-#-#%*#
 #---#--#
 #####&-#
 ########
 
 Level 4
 
 ########
 #----###
 #-##-###
 #--%---#
 #%*%-%-#
 #&*##%##
 #**---##
 ########
 
 Level 5
 
 #########
 ##--#####
 #--%%---#
 #&%--*-##
 ####*#*##
 ##-%-*--#
 ##-----##
 #########
 
 Level 6
 
 #######
 ##--*-#
 #--*#-#
 #&--*-#
 ##-##-#
 ##-%--#
 ##-%--#
 ##-#%-#
 ##-%-##
 ##----#
 #######
 
 Level 7
 
 ######
 ##---#
 #--%-#
 #&%--#
 ###-##
 #****#
 #-%%-#
 ##---#
 ######
 
 Level 8
 
 ########
 ##----##
 #--%---#
 #-%%%#&#
 #-%--###
 ##-%-#*#
 ####-#*#
 #-----*#
 #-#---*#
 #-##%#*#
 #----**#
 ########
 
 Level 9
 
 ########
 #----&-#
 #-%--#-#
 ###%##-#
 ##-*-%-#
 ##-*-#-#
 ###**%-#
 ####*%-#
 ######-#
 ########
 
 Level 10
 
 ############
 #####-----##
 #-**#-###-##
 #-*##------#
 ##--#--#---#
 ##--&-###%-#
 ##--#--#---#
 ###-#---%-##
 ###---%-#--#
 ###---######
 ############
 
 */

import Foundation

class LevelsProvider: LevelsProviderInterface {
    
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
        addLevelWith(name: "Level 1",
                     order: 1,
                     sceneWidth: 10,
                     sceneHeight: 5,
                     sceneMatrix: "###########--#--#--##---&----##-*--%---###########")
        addLevelWith(name: "Level 2",
                     order: 2,
                     sceneWidth: 7,
                     sceneHeight: 8,
                     sceneMatrix: "###########--##--#--##-*-*-##-&%%-##-#-####---##########")
        addLevelWith(name: "Level 3",
                     order: 3,
                     sceneWidth: 8,
                     sceneHeight: 8,
                     sceneMatrix: "#########---#--##-#-#%*##----%*##-#-#%*##---#--######&-#########")
        addLevelWith(name: "Level 4",
                     order: 4,
                     sceneWidth: 8,
                     sceneHeight: 8,
                     sceneMatrix: "#########----####-##-####--%---##%*%-%-##&*##%###**---##########")
        addLevelWith(name: "Level 5",
                     order: 5,
                     sceneWidth: 9,
                     sceneHeight: 8,
                     sceneMatrix: "###########--######--%%---##&%--*-######*#*####-%-*--###-----###########")
        addLevelWith(name: "Level 6",
                     order: 6,
                     sceneWidth: 7,
                     sceneHeight: 11,
                     sceneMatrix: "#########--*-##--*#-##&--*-###-##-###-%--###-%--###-#%-###-%-####----########")
        addLevelWith(name: "Level 7",
                     order: 7,
                     sceneWidth: 6,
                     sceneHeight: 9,
                     sceneMatrix: "########---##--%-##&%--####-###****##-%%-###---#######")
        addLevelWith(name: "Level 8",
                     order: 8,
                     sceneWidth: 8,
                     sceneHeight: 12,
                     sceneMatrix: "##########----###--%---##-%%%#&##-%--#####-%-#*#####-#*##-----*##-#---*##-##%#*##----**#########")
        addLevelWith(name: "Level 9",
                     order: 9,
                     sceneWidth: 8,
                     sceneHeight: 10,
                     sceneMatrix: "#########----&-##-%--#-####%##-###-*-%-###-*-#-####**%-#####*%-#######-#########")
        addLevelWith(name: "Level 10",
                     order: 10,
                     sceneWidth: 12,
                     sceneHeight: 11,
                     sceneMatrix: "#################-----###-**#-###-###-*##------###--#--#---###--&-###%-###--#--#---####-#---%-#####---%-#--####---##################")
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
