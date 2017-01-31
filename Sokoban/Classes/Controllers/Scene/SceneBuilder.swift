//
//  SceneBuilder.swift
//  Sokoban
//

import UIKit
import Foundation

var coordsOfCell = Array<(cellDetail: String, x: Int, y: Int)>()
var sceneController = SceneController()

class SceneBuilder : UIView, SceneBuilderInterface {
    
    var wallViewArray: [WallCell] = []
    var floorViewArray: [FloorCell] = []
    var blockCellIn: [BlockCellIn] = []
    var blockCellOut: [BlockCellOut] = []
    var dotCell: [Dot] = []
    var playerView: UIImageView!
    
    var player = PlayerCell()
    
    var dimensionOfCell = 40
    var sceneWidth = 0
    var sceneHeight = 0
    
    var scene: UIView? = nil
    func getSceneCanvas(level: Level) -> UIView {
        
        sceneWidth = level.scene?.width as! Int
        sceneHeight = level.scene?.height as! Int
        var levelStr = level.scene?.matrix
        let levelData = levelStr?.characters.map { String($0) }
        
        scene = UIView(frame: CGRect(x: 0, y: 0, width: sceneWidth * dimensionOfCell, height: sceneHeight * dimensionOfCell))
//        scene?.backgroundColor = UIColor.gray
        
        
        
        var playerCoordX: Int = 0
        var playerCoordY: Int = 0
        var i = 0
        
        var countWidth = 0
        var countHeight = 0
        for levelItem in levelData! {
            drawFloor(frame: CGRect(x: dimensionOfCell * countWidth, y: dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
            countWidth += 1
            if countWidth == sceneWidth {
                countWidth = 0
                countHeight += 1
            }
            i += 1
        }
         countWidth = 0
         countHeight = 0
        
        for levelItem in levelData! {
//            drawFloor(frame: CGRect(x: dimensionOfCell * countWidth, y: dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
            switch levelItem {
            case "#":
                drawWall(frame: CGRect(x: dimensionOfCell * countWidth, y: dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                coordsOfCell.append(("#", dimensionOfCell * countWidth, dimensionOfCell * countHeight))
            case "-":
                coordsOfCell.append(("-", dimensionOfCell * countWidth, dimensionOfCell * countHeight))
            case "*":
                drawDot(frame: CGRect(x: dimensionOfCell * countWidth, y: dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                drawBlockCellIn(frame: CGRect(x: dimensionOfCell * countWidth, y: dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                coordsOfCell.append(("*", dimensionOfCell * countWidth, dimensionOfCell * countHeight))
            case "%":
                drawBlockCellOut(frame: CGRect(x: dimensionOfCell * countWidth, y: dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                coordsOfCell.append(("%", dimensionOfCell * countWidth, dimensionOfCell * countHeight))
            case "&":
                playerCoordX = dimensionOfCell * countWidth
                playerCoordY = dimensionOfCell * countHeight
                coordsOfCell.append(("&", dimensionOfCell * countWidth, dimensionOfCell * countHeight))
            default:
                break
            }
            countWidth += 1
            if countWidth == sceneWidth {
                countWidth = 0
                countHeight += 1
            }
            i += 1
        }
        drawPlayer(frame: CGRect(x: playerCoordX, y: playerCoordY, width: dimensionOfCell, height: dimensionOfCell))
        return scene!
    }
    
    func drawWall(frame: CGRect) {
        wallViewArray.append(WallCell(frame: frame))
        scene?.addSubview(wallViewArray.last!)
    }
    
    func drawPlayer(frame: CGRect) {
        let image = UIImage(named: "down1")
        playerView = UIImageView(image: image)
        playerView.frame = frame
        scene?.addSubview(playerView)
    }
    
    func drawFloor(frame: CGRect) {
        floorViewArray.append(FloorCell(frame: frame))
        scene?.addSubview(floorViewArray.last!)
    }
    
    func drawBlockCellIn(frame: CGRect) {
        blockCellIn.append(BlockCellIn(frame: frame))
        blockCellIn.last?.isHidden = true
        scene?.addSubview(blockCellIn.last!)
    }
    
    func drawBlockCellOut(frame: CGRect) {
        blockCellOut.append(BlockCellOut(frame: frame))
        scene?.addSubview(blockCellOut.last!)
    }
    
    func drawDot(frame: CGRect) {
        dotCell.append(Dot(frame: frame))
        scene?.addSubview(dotCell.last!)
    }
    
}
