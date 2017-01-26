//
//  PlayersProvider.swift
//  Sokoban
//
//  Created by Oleksiy Bilyi on 1/21/17.
//
//

import UIKit

class PlayersProvider: PlayersProviderInterface {
    
    static private(set) var currentPlayer : Player? = {
        let request = Player.fetchRequest()
        let players = getPlayers()
        if let lastPlayer = UserDefaults.standard.value(forKey: "currentPlayer") as! String? {
            for player in players! {
                if player.name == lastPlayer { return player }
            }
        } else {
            UserDefaults.standard.setValue(players?[0].name, forKey: "currentPlayer")
        }
        return players?[0]
    }()
    
    /**
     Sets the property currentPlayer
     
     - Parameter name: name of the player that needs to be set to property currentPlayer
    */
    static func setCurrentPlayerWith(name : String) {
        UserDefaults.standard.setValue(name, forKey: "currentPlayer")
        let players = getPlayers()
        for player in players! {
            if player.name == name { currentPlayer = player }
        }
    }
    
    /**
     Deletes senders player
     
     - Parameter player: player that needs to be deleted
     */
    static func deletePlayer(_ player : Player) {
        CoreDataStack.sharedStack.managedContext.delete(player)
        CoreDataStack.sharedStack.saveContext()
    }
    
    /**
     Returns all players from data base
     
     - Returns: An array of all players
     */
    static func getPlayers() -> [Player]? {
        let dataStack = CoreDataStack.sharedStack
        var players = [Player]()
        let request = Player.fetchRequest()
        do {
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
     - Parameter photo: photo of player
     */
    static func addPlayerWith(name : String, score : NSNumber, levelsScores: NSArray, photo: UIImage) {
        let dataStack = CoreDataStack.sharedStack
        let player = Player(context:dataStack.managedContext)
        player.name = name
        player.score = score
        if let photoData = UIImagePNGRepresentation(photo) {
            player.photo = Data(photoData)
        }
        player.levelsScores = NSKeyedArchiver.archivedData(withRootObject: levelsScores)
        dataStack.saveContext()
    }
    
    /**
     Saves changes, that was made to currentPlayer
    */
    static func saveCurrentPlayer() {
        CoreDataStack.sharedStack.saveContext()
    }



}
