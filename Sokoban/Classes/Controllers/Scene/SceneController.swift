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
    
    var sceneBuilder = SceneBuilder()
    var scrollView: UIScrollView!
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneBuilder.player.initPlayer()
        view.addSubview(sceneBuilder.getSceneCanvas(level: (LevelsProvider.getLevels()?[4])!))
        view.backgroundColor = UIColor.gray
        
        //TODO: complete ScrollView
//        scrollView = UIScrollView(frame: view.bounds)
//        scrollView.contentSize = view.bounds.size
//        scrollView.addSubview(view)
//        if view.frame.height <= scrollView.frame.height {
//            let shiftHeight = scrollView.frame.height/2.0 - scrollView.contentSize.height/2.0
//            scrollView.contentInset.top = shiftHeight
//        }
//        if view.frame.width <= scrollView.frame.width {
//            let shiftWidth = scrollView.frame.width/2.0 - scrollView.contentSize.width/2.0
//            scrollView.contentInset.left = shiftWidth
//        }
//         scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//        foreground.delegate = self
    }
    
    //TODO: complete ScrollView
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//                let foregroundHeight = foreground.contentSize.height - foreground.bounds.height
//                let percentageScroll = foreground.contentOffset.y / foregroundHeight
//                let backgroundHeight = background.contentSize.height - background.bounds.height
//        
//                background.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll)
//        
//        let foregroundWidth = foreground.contentSize.width - foreground.bounds.width
//        let percentageScroll = foreground.contentOffset.x / foregroundWidth
//        let backgroundWidth = background.contentSize.width - background.bounds.width
//        
//        background.contentOffset = CGPoint(x: backgroundWidth * percentageScroll, y: 0)
//        
//    }
    
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
