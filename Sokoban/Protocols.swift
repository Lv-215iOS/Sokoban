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
    func movePlayer(operation:Moves)
}

protocol SceneBuilderInterface {
    func getSceneCanvas(sceneW: Int, SceneH: Int, levelData: Array<String>) -> UIView
}
