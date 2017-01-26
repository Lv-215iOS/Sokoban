//
//  SceneBuilder.swift
//  Sokoban
//
//  Created by adminaccount on 1/23/17.
//
//


import UIKit
import Foundation

class SceneBuilder : UIView, SceneBuilderInterface {
    var dimensionOfCell = 30
    var sceneWidth = 0
    var sceneHeight = 0
    
    var countWidth = 0
    var countHeight = 0
    
    var rectX = 0
    var rectY = 0
    
    var scene = UIView()
    func getSceneCanvas(sceneW: Int, SceneH: Int, levelData: Array<String>) -> UIView {
        let sceneController = SceneController()
        sceneWidth = sceneW
        sceneHeight = SceneH
        for levelItem in levelData {
            switch levelItem {
                case "#":
                    sceneController.drawWall(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                case "-":
                    sceneController.drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                case "*":
                    sceneController.drawDot(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                case "%":
                    sceneController.drawBlockCellIn(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                case "&":
                    scene.addSubview(FloorCell(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell)))
                    sceneController.drawPlayer(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                    scene.addSubview(sceneController.view)
                default:
                    sceneController.drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
            }
            countWidth += 1
            if countWidth == sceneWidth {
                countWidth = 0
                countHeight += 1
            }
        }
        return scene
    }
}



