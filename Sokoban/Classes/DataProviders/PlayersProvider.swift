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
                addPlayer()
            }
            players = try dataStack.managedContext.fetch(request)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return players
    }
    /// add first player
    private static func addPlayer() {
        let dataStack = CoreDataStack.sharedStack
        let player = Player(context:dataStack.managedContext)
        player.name = "testPlayer"
        player.score = 100500
        dataStack.saveContext()
    }


}
