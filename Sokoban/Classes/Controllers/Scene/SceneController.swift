//
//  SceneController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class SceneController: UIViewController, UIScrollViewDelegate, SceneControllerInterface {
    //TODO: complete ScrollView
    //    @IBOutlet weak var background: UIScrollView!
    //    @IBOutlet weak var foreground: UIScrollView!
    
    var currentLevel: Level?
    
    var sceneBuilder = SceneBuilder()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    /// take actions from PlaygroundController to start moving
    func movePlayerButtons(operation: Moves) {
        switch operation {
        case .Right:
            animateImage(type: sceneBuilder.player.imageListRight)
            changePlayerPosition(sceneBuilder.playerView!, x: 1, y: 0)
        case .Up:
            animateImage(type: sceneBuilder.player.imageListUp)
            changePlayerPosition(sceneBuilder.playerView!, x: 0, y: -1)
        case .Left:
            animateImage(type: sceneBuilder.player.imageListLeft)
            changePlayerPosition(sceneBuilder.playerView!, x: -1, y: 0)
        case .Down:
            animateImage(type: sceneBuilder.player.imageListDown)
            changePlayerPosition(sceneBuilder.playerView!, x: 0, y: 1)
        }
    }
    
    /// take action from PlaygroundController to restart level
    func restartLevel() {
        self.viewDidAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sceneBuilder.player.initPlayer()
        
        let gameView = sceneBuilder.getSceneCanvas(level: currentLevel!)
        
        contentWidth.constant = max(gameView.frame.size.width, scrollView.frame.size.width)
        contentHeight.constant = max(gameView.frame.size.height, scrollView.frame.size.height)
        scrollView.layoutIfNeeded()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        gameView.center = CGPoint(x: contentWidth.constant / 2, y: contentHeight.constant / 2)
        contentView.addSubview(gameView)
    }
    
    /// animate players moves
    func animateImage(type: [UIImage]) {
        sceneBuilder.playerView?.animationImages = type
        sceneBuilder.playerView?.animationDuration = 0.35
        sceneBuilder.playerView?.startAnimating()
        delay(delay: 0.35) {
            self.sceneBuilder.playerView?.stopAnimating()
        }
    }
    
    func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    func changePlayerPosition(_ player: UIImageView, x: Int, y: Int) {
        if isWallNearPlayer(player, x: x, y: y) {
            return
        } else {
            moveBlock(player, x: x, y: y)
            movePlayer(player, x: x, y: y)
        }
    }
    
    /// check if player is able to move
    func movePlayer(_ player: UIImageView, x: Int, y: Int) {
        //FIX: player go over block, when block is near wall
        //      for block in 0..<sceneBuilder.blockCellOut.count {
        //           if !(isBlockNearBlock(sceneBuilder.blockCellOut[block], x: x, y: y) && isWallNearBlock(sceneBuilder.blockCellOut[block], x: x, y: y)) {
        //                   }
        //                }
        UIView.animate(withDuration: 0.35) {
            player.center.x += CGFloat(x) * player.bounds.size.width
            player.center.y += CGFloat(y) * player.bounds.size.height
        }
    }
    
    /// check if wall is next to player
    func isWallNearPlayer(_ player: UIImageView, x: Int, y: Int) -> Bool {
        for wall in sceneBuilder.wallViewArray {
            if wall.center.x == (player.center.x + CGFloat(x) * player.bounds.size.width) && wall.center.y == (player.center.y + CGFloat(y) * player.bounds.size.height) {
                return true
            }
        }
        
        return false
    }
    
    /// check if wall is next to block
    func isWallNearBlock(_ block: UIView, x: Int, y: Int) -> Bool {
        for wall in sceneBuilder.wallViewArray {
            if wall.center.x == (block.center.x + CGFloat(x) * block.bounds.size.width) && wall.center.y == (block.center.y + CGFloat(y) * block.bounds.size.height) {
                return true
            }
        }
        return false
    }
    
    /// check if block is next to block
    func isBlockNearBlock(_ block: UIView, x: Int, y: Int) -> Bool {
        for block in sceneBuilder.blockCellOut {
            for blockNext in sceneBuilder.blockCellOut {
                if block.center.x == (blockNext.center.x + CGFloat(x) * blockNext.bounds.size.width) && block.center.y == (blockNext.center.y + CGFloat(y) * blockNext.bounds.size.height) {
                    return true
                    
                }
            }
        }
        return false
    }
    
    /**
     Moves block with direction
     
     - Parameter player: players subview
     - Parameter x: x coordinate
     - Parameter y: y coordinate
     */
    func moveBlock(_ player: UIImageView, x: Int, y: Int) {
        for block in 0..<sceneBuilder.blockCellOut.count {
            if isWallNearBlock(sceneBuilder.blockCellOut[block], x: x, y: y) {
                return
                //FIX: player go over blocks when block is near block
                //            } else if isBlockNearBlock(sceneBuilder.blockCellOut[block], x: x, y: y) {
                //                return
            } else if (player.center.x + CGFloat(x) * player.bounds.size.width) == sceneBuilder.blockCellOut[block].center.x && (player.center.y + CGFloat(y) * player.bounds.size.height) == sceneBuilder.blockCellOut[block].center.y {
                if isBlockOnDot(block: sceneBuilder.blockCellOut[block]) {
                    let newBlock = findBlockIn(x: sceneBuilder.blockCellOut[block].center.x, y: sceneBuilder.blockCellOut[block].center.y)
                    newBlock.isHidden = true
                } else {
                    sceneBuilder.blockCellOut[block].center.x += CGFloat(x) * player.bounds.size.width
                    sceneBuilder.blockCellOut[block].center.y += CGFloat(y) * player.bounds.size.height
                    if isBlockOnDot(block: sceneBuilder.blockCellOut[block]) {
                        let newBlock = findBlockIn(x: sceneBuilder.blockCellOut[block].center.x, y: sceneBuilder.blockCellOut[block].center.y)
                        sceneBuilder.blockCellOut[block].center.x -= CGFloat(x) * player.bounds.size.width
                        sceneBuilder.blockCellOut[block].center.y -= CGFloat(y) * player.bounds.size.height
                        UIView.animate(withDuration: 0.35) {
                            self.sceneBuilder.blockCellOut[block].center.x += CGFloat(x) * player.bounds.size.width
                            self.sceneBuilder.blockCellOut[block].center.y += CGFloat(y) * player.bounds.size.height
                        }
                        delay(delay: 0.25) {
                            newBlock.isHidden = false
                        }
                        return
                    }
                    sceneBuilder.blockCellOut[block].center.x -= CGFloat(x) * player.bounds.size.width
                    sceneBuilder.blockCellOut[block].center.y -= CGFloat(y) * player.bounds.size.height
                }
                UIView.animate(withDuration: 0.35) {
                    self.sceneBuilder.blockCellOut[block].center.x += CGFloat(x) * player.bounds.size.width
                    self.sceneBuilder.blockCellOut[block].center.y += CGFloat(y) * player.bounds.size.height
                }
                
            }
        }
    }
    
    // check if block is on cell
    func isBlockOnDot(block: BlockCellOut) -> Bool {
        for dot in sceneBuilder.dotCell {
            if block.center.x == dot.center.x && block.center.y == dot.center.y {
                return true
            }
        }
        return false
    }
    
    func findBlockIn(x: CGFloat, y: CGFloat) -> BlockCellIn {
        for block in sceneBuilder.blockCellIn {
            if block.center.x == x && block.center.y == y {
                return block
            }
        }
        return sceneBuilder.blockCellIn.last!
    }
    
    func isFinish() -> Bool {
        for block in sceneBuilder.blockCellIn {
            if block.isHidden {
                return false
            }
        }
        //save result
        _ = navigationController?.popToRootViewController(animated: true)
        return true
    }
}
