//
//  SceneBuilder.swift
//  Sokoban
//
//  Created by adminaccount on 1/23/17.
//
//


import UIKit
import Foundation

var coordsOfCell = Array<(cellDetail: String, x: Int, y: Int)>()
var sceneController = SceneController()

class SceneBuilder : UIView, SceneBuilderInterface {
    
    var dimensionOfCell = 40
    var sceneWidth = 0
    var sceneHeight = 0
    
    var countWidth = 0
    var countHeight = 0
    
    var rectX = 0
    var rectY = 0
    
    var scene = UIView()
    func getSceneCanvas(level: Level) -> UIView {
        
        sceneWidth = level.scene?.width as! Int
        sceneHeight = level.scene?.height as! Int
        var levelStr = level.scene?.matrix
        //var levelData = Array<String>()
        
        let levelData = levelStr?.characters.map { String($0) }
        
        //let sceneController = SceneController()
        //sceneWidth = sceneW
        //sceneHeight = SceneH
        var i = 0
        for levelItem in levelData! {
            switch levelItem {
            case "#":
                drawWall(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
                coordsOfCell.append(("#", rectX + dimensionOfCell * countWidth, rectY + dimensionOfCell * countHeight))
            case "-":
                drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
                coordsOfCell.append(("-", rectX + dimensionOfCell * countWidth, rectY + dimensionOfCell * countHeight))
            case "*":
                drawDot(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
                coordsOfCell.append(("*", rectX + dimensionOfCell * countWidth, rectY + dimensionOfCell * countHeight))
            case "%":
                drawBlockCellOut(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
                coordsOfCell.append(("%", rectX + dimensionOfCell * countWidth, rectY + dimensionOfCell * countHeight))
            case "&":
                drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                drawPlayer(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
                coordsOfCell.append(("&", rectX + dimensionOfCell * countWidth, rectY + dimensionOfCell * countHeight))
            default:
                drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
            }
            countWidth += 1
            if countWidth == sceneWidth {
                countWidth = 0
                countHeight += 1
            }
            i += 1
        }
        return scene
    }
    
    func drawWall(frame: CGRect) {
        sceneController.wallViewArray.append(WallCell(frame: frame))
        scene.addSubview(sceneController.wallViewArray.last!)
    }
    
    func drawPlayer(frame: CGRect) {
        let image = UIImage(named: "down1")
        sceneController.playerView = UIImageView(image: image)
        sceneController.playerView.frame = frame
        scene.addSubview(sceneController.playerView)
    }
    
    func drawFloor(frame: CGRect) {
        sceneController.floorViewArray.append(FloorCell(frame: frame))
        scene.addSubview(sceneController.floorViewArray.last!)
    }
    
    func drawBlockCellIn(frame: CGRect) {
        sceneController.blockCellIn.append(BlockCellIn(frame: frame))
        sceneController.blockCellIn.last?.isHidden = true
        scene.addSubview(sceneController.blockCellIn.last!)
    }
    
    func drawBlockCellOut(frame: CGRect) {
        sceneController.blockCellOut.append(BlockCellOut(frame: frame))
        scene.addSubview(sceneController.blockCellOut.last!)
    }
    
    func drawDot(frame: CGRect) {
        sceneController.dotCell.append(Dot(frame: frame))
        scene.addSubview(sceneController.dotCell.last!)
    }
    
}



