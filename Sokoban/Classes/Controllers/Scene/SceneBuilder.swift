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
    
    var levels: PlaygroundController? = nil
    var player = PlayerCell()
    
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
        let levelData = levelStr?.characters.map { String($0) }
        var i = 0
        for levelItem in levelData! {
            switch levelItem {
            case "#":
                drawWall(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))

            case "-":
                drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))

            case "*":
                drawDot(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
            case "%":
                drawBlockCellOut(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
            case "&":
                drawFloor(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                drawPlayer(frame: CGRect(x: rectX + dimensionOfCell * countWidth, y: rectY + dimensionOfCell * countHeight, width: dimensionOfCell, height: dimensionOfCell))
                
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
        wallViewArray.append(WallCell(frame: frame))
        scene.addSubview(wallViewArray.last!)
    }
    
    func drawPlayer(frame: CGRect) {
        let image = UIImage(named: "down1")
        playerView = UIImageView(image: image)
        playerView.frame = frame
        scene.addSubview(playerView)
    }
    
    func drawFloor(frame: CGRect) {
        floorViewArray.append(FloorCell(frame: frame))
        scene.addSubview(floorViewArray.last!)
    }
    
    func drawBlockCellIn(frame: CGRect) {
        blockCellIn.append(BlockCellIn(frame: frame))
        blockCellIn.last?.isHidden = true
        scene.addSubview(blockCellIn.last!)
    }
    
    func drawBlockCellOut(frame: CGRect) {
        blockCellOut.append(BlockCellOut(frame: frame))
        scene.addSubview(blockCellOut.last!)
    }
    
    func drawDot(frame: CGRect) {
        dotCell.append(Dot(frame: frame))
        scene.addSubview(dotCell.last!)
    }

}

