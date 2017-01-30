//
//  Protocols.swift
//  Sokoban
//
//  Created by adminaccount on 1/26/17.
//
//

import Foundation
import UIKit

enum Moves: String {
    case Left = "👈"
    case Right = "👉"
    case Down = "👇🏿"
    case Up = "👆"
}

protocol SceneControllerInterface {
    func restartLevel()
    func movePlayerButtons(operation:Moves)
}

protocol SceneBuilderInterface {
    func getSceneCanvas(level: Level) -> UIView
}
 
protocol PlayersProviderInterface {
    static var fetchedResultController : NSFetchedResultsController<Player> { get }
    static var currentPlayer : Player? { get }
    static func setCurrentPlayerWith(name : String)
    static func deletePlayer(_ player : Player)
    static func getPlayers() -> [Player]?
    static func saveCurrentPlayer()
    static func addPlayerWith(name : String,
                              score : NSNumber,
                              levelsScores: NSArray,
                              photo: UIImage)
}

protocol LevelsProviderInterface {
    static func getLevels() -> [Level]?
    static func addDefaultLevels()
    static func addLevelWith( name: String,
                              order: NSNumber,
                              sceneWidth: NSNumber,
                              sceneHeight: NSNumber,
                              sceneMatrix: String)
}
