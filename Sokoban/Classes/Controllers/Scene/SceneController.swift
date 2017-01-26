//
//  SceneController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class SceneController: UIViewController {
    
    var wallViewArray: [WallCell] = []
    var floorViewArray: [FloorCell] = []
    var blockCellIn: [BlockCellIn] = []
    var blockCellOut: [BlockCellOut] = []
    var dotCell: [Dot] = []
    var playerView: UIImageView!
    
    var levels: PlaygroundController? = nil
    var player = PlayerCell()
    
    var model: [[ModelType]] = []
    struct ModelType {
        var point: (x: Int, y: Int)
        var type: Character
    }
    
    func animatePlayer(title: String) {
        switch title {
        case "👉":
            animateImage(type: player.imageListRight)
            changePlayerPosition(playerView, x: 1, y: 0)
        case "👆":
            animateImage(type: player.imageListUp)
            changePlayerPosition(playerView, x: 0, y: -1)
        case "👈":
            animateImage(type: player.imageListLeft)
            changePlayerPosition(playerView, x: -1, y: 0)
        case "👇🏿":
            animateImage(type: player.imageListDown)
            changePlayerPosition(playerView, x: 0, y: 1)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.initPlayer()
        
        //For Sasha
        drawFloor(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 40, y: 0, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 80, y: 0, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 120, y: 0, width: 40, height: 40))
        
        drawFloor(frame: CGRect(x: 0, y: 40, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 40, y: 40, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 80, y: 40, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 120, y: 40, width: 40, height: 40))
        
        drawFloor(frame: CGRect(x: 0, y: 80, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 40, y: 80, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 80, y: 80, width: 40, height: 40))
        drawFloor(frame: CGRect(x: 120, y: 80, width: 40, height: 40))
        
        drawDot(frame: CGRect(x: 130, y: 10, width: 20, height: 20))
        
        drawBlockCellOut(frame: CGRect(x: 120, y: 80, width: 40, height: 40))
        
        drawBlockCellIn(frame: CGRect(x: 120, y: 0, width: 40, height: 40))
        
        drawWall(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        drawPlayer(frame: CGRect(x: 40, y: 0, width: 40, height: 40))
    }
    
    func animateImage(type: [UIImage]) {
        playerView.animationImages = type
        playerView.animationDuration = 0.35
        playerView.startAnimating()
        delay(delay: 0.35) {
            self.playerView.stopAnimating()
        }
    }
    
    func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    /**
     Get level matrix with width and heigth
     
     - Parameter level: order of level
     
     - Returns width: width of matrix
     - Returns height: heigth of matrix
     - Returns matrix: array of elements
    */
    func getLevel(_ level: Int) -> (width: NSNumber?, height: NSNumber?, matrix: Array<String>) {
        let levelScene = levels?.currentLevel?.scene
        let levelHeight = levelScene?.height
        let levelWidth = levelScene?.width
        let levelMatrix = levelScene?.matrix?.characters.map { String($0) }
        return (levelWidth, levelHeight, levelMatrix!)
    }
    
    func changePlayerPosition(_ player: UIImageView, x: Int, y: Int) {
        if isWallNearPlayer(player, x: x, y: y) {
            return
        } else {
            moveBlock(player, x: x, y: y)
            movePlayer(player, x: x, y: y)
        }
    }
    
    func movePlayer(_ player: UIImageView, x: Int, y: Int) {
        for block in 0..<blockCellOut.count {
            if !(isWallNearPlayer(player, x: x * 2, y: y * 2) && isWallNearBlock(blockCellOut[block], x: x, y: y)) {
                UIView.animate(withDuration: 0.35) {
                    player.center.x += CGFloat(x) * player.bounds.size.width
                    player.center.y += CGFloat(y) * player.bounds.size.height
                }
            }
        }
    }
    
    func isWallNearPlayer(_ player: UIImageView, x: Int, y: Int) -> Bool {
        for wall in wallViewArray {
            if wall.center.x == (player.center.x + CGFloat(x) * player.bounds.size.width) && wall.center.y == (player.center.y + CGFloat(y) * player.bounds.size.height) {
                return true
            }
        }
        return false
    }
    
    func isWallNearBlock(_ block: UIView, x: Int, y: Int) -> Bool {
        for wall in wallViewArray {
            if wall.center.x == (block.center.x + CGFloat(x) * block.bounds.size.width) && wall.center.y == (block.center.y + CGFloat(y) * block.bounds.size.height) {
                return true
            }
        }
        return false
    }
    
    func isBlockNearBlock(_ block: UIView, x: Int, y: Int) -> Bool {
        for block in blockCellOut {
            for blockNext in blockCellOut {
                if block.center.x == (blockNext.center.x + CGFloat(x) * blockNext.bounds.size.width) && block.center.y == (blockNext.center.y + CGFloat(y) * blockNext.bounds.size.height) {
                    return true
                }
            }
        }
        return false
    }


    func moveBlock(_ player: UIImageView, x: Int, y: Int) {
        for block in 0..<blockCellOut.count {
            if isWallNearBlock(blockCellOut[block], x: x, y: y) {
                return
            } else if isBlockNearBlock(blockCellOut[block], x: x, y: y) {
                return
            } else if (player.center.x + CGFloat(x) * player.bounds.size.width) == blockCellOut[block].center.x && (player.center.y + CGFloat(y) * player.bounds.size.height) == blockCellOut[block].center.y {
                if isBlockOnDot(block: blockCellOut[block]) {
                    let newBlock = findBlockIn(x: blockCellOut[block].center.x, y: blockCellOut[block].center.y)
                    newBlock.isHidden = true
                } else {
                    blockCellOut[block].center.x += CGFloat(x) * player.bounds.size.width
                    blockCellOut[block].center.y += CGFloat(y) * player.bounds.size.height
                    if isBlockOnDot(block: blockCellOut[block]) {
                        let newBlock = findBlockIn(x: blockCellOut[block].center.x, y: blockCellOut[block].center.y)
                        blockCellOut[block].center.x -= CGFloat(x) * player.bounds.size.width
                        blockCellOut[block].center.y -= CGFloat(y) * player.bounds.size.height
                        UIView.animate(withDuration: 0.35) {
                            self.blockCellOut[block].center.x += CGFloat(x) * player.bounds.size.width
                            self.blockCellOut[block].center.y += CGFloat(y) * player.bounds.size.height
                        }
                        delay(delay: 0.25) {
                            newBlock.isHidden = false
                        }
                        return
                    }
                    blockCellOut[block].center.x -= CGFloat(x) * player.bounds.size.width
                    blockCellOut[block].center.y -= CGFloat(y) * player.bounds.size.height
                }
                UIView.animate(withDuration: 0.35) {
                    self.blockCellOut[block].center.x += CGFloat(x) * player.bounds.size.width
                    self.blockCellOut[block].center.y += CGFloat(y) * player.bounds.size.height
                }
                
            }
        }
    }
    
    func isBlockOnDot(block: BlockCellOut) -> Bool {
        for dot in dotCell {
            if block.center.x == dot.center.x && block.center.y == dot.center.y {
                return true
            }
        }
        return false
    }
    
    func findBlockIn(x: CGFloat, y: CGFloat) -> BlockCellIn {
        for block in blockCellIn {
            if block.center.x == x && block.center.y == y {
                return block
            }
        }
        return blockCellIn.last!
    }
    
    func drawWall(frame: CGRect) {
        wallViewArray.append(WallCell(frame: frame))
        self.view.addSubview(wallViewArray.last!)
    }
    
    func drawPlayer(frame: CGRect) {
        let image = UIImage(named: "down1")
        playerView = UIImageView(image: image)
        playerView.frame = frame
        self.view.addSubview(playerView)
    }
    
    func drawFloor(frame: CGRect) {
        floorViewArray.append(FloorCell(frame: frame))
        self.view.addSubview(floorViewArray.last!)
    }
    
    func drawBlockCellIn(frame: CGRect) {
        blockCellIn.append(BlockCellIn(frame: frame))
        blockCellIn.last?.isHidden = true
        self.view.addSubview(blockCellIn.last!)
    }
    
    func drawBlockCellOut(frame: CGRect) {
        blockCellOut.append(BlockCellOut(frame: frame))
        self.view.addSubview(blockCellOut.last!)
    }
    
    func drawDot(frame: CGRect) {
        dotCell.append(Dot(frame: frame))
        self.view.addSubview(dotCell.last!)
    }
    
    func isFinish() -> Bool {
        for block in blockCellIn {
            if block.isHidden {
                return false
            }
        }
        //save result
        _ = navigationController?.popToRootViewController(animated: true)
        return true
    }
}
