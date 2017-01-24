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
    ///returns all players
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
    
    /// add first player
    static func addPlayerWith(name : String, score : NSNumber, levelsScores: NSArray) {
        let dataStack = CoreDataStack.sharedStack
        let player = Player(context:dataStack.managedContext)
        player.name = name
        player.score = score
        player.levelsScores = NSKeyedArchiver.archivedData(withRootObject: levelsScores)
        dataStack.saveContext()
    }


}
