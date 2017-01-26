//
//  Protocols.swift
//  Sokoban
//
//  Created by adminaccount on 1/26/17.
//
//

import Foundation

enum Moves: String {
    case Left = "👈"
    case Right = "👉"
    case Down = "👇🏿"
    case Up = "👆"
}

protocol SceneControllerInterface {
    func restartLevel()
    func movePlayer(operation:Moves)
}
