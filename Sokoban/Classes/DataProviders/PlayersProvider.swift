//
//  PlayersProvider.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/21/17.
//
//
/*
 first player example
 
 name - testPlayer
 score - 100500
 
 */


import UIKit

class PlayersProvider {
    
    static private(set) var currentPlayer : Player? = {
        let request = Player.fetchRequest()
        var players = getPlayers()
        if let lastPlayer = UserDefaults.standard.value(forKey: "currentPlayer") as! String? {
            for player in players! {
                if player.name == lastPlayer { return player }
            }
        }
        return players?[0]
    }()
    
    /**
     Sets the property currentPlayer
     
     - Parameter player: player that needs to be set to property currentPlayer
    */
    static func setCurrentPlayer(_ player : Player) {
        UserDefaults.standard.setValue(player.name, forKey: "currentPlayer")
        currentPlayer = player
    }

    
    /**
     Returns all players drom data base
     
     - Returns: An array of all players
     */
    static func getPlayers() -> [Player]? {
        let dataStack = CoreDataStack.sharedStack
        var players = [Player]()
        let request = Player.fetchRequest()
        do {
            let count = try dataStack.managedContext.count(for: request)
            if count == 0 {
                addPlayerWith(name: "testPlayer", score: 100500, levelsScores: [0.0])
            }
            players = try dataStack.managedContext.fetch(request)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return players
    }
    
    /**
     Inserts a new player to data base
     
     - Parameter name: name of player
     - Parameter score: global score of player
     - Parameter levelsScores: Array of level scores for passed levels of player
     */
    static func addPlayerWith(name : String, score : NSNumber, levelsScores: NSArray) {
        let dataStack = CoreDataStack.sharedStack
        let player = Player(context:dataStack.managedContext)
        player.name = name
        player.score = score
        player.levelsScores = NSKeyedArchiver.archivedData(withRootObject: levelsScores)
        dataStack.saveContext()
    }


}
