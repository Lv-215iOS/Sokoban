//
//  SceneController.swift
//  Sokoban
//
//  Created by Dmytro on 1/18/17.
//
//

import UIKit

class SceneController: UIViewController, UIScrollViewDelegate, SceneControllerInterface, GameLogic {
    
    //MARK: Declaration of values
    var currentLevel: Level?
    var resetMatrix: String!
    var matrix: String!
    var indexBlock: [Int] = []
    var temp = 0
    var levelController: LevelsController? = nil
    var playgroundController: PlaygroundController? = nil
    var sceneBuilder: SceneBuilder! = SceneBuilder()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    /**
     Take action from PlaygroundController to start moving
     
     - Parameter operation: move direction
     */
    func movePlayerButtons(operation: Moves) {
        switch operation {
        case .Right:
            animateImage(type: sceneBuilder.player.imageListRight)
            movePlayer(sceneBuilder.playerView!, x: 1, y: 0)
        case .Up:
            animateImage(type: sceneBuilder.player.imageListUp)
            movePlayer(sceneBuilder.playerView!, x: 0, y: -1)
        case .Left:
            animateImage(type: sceneBuilder.player.imageListLeft)
            movePlayer(sceneBuilder.playerView!, x: -1, y: 0)
        case .Down:
            animateImage(type: sceneBuilder.player.imageListDown)
            movePlayer(sceneBuilder.playerView!, x: 0, y: 1)
        }
    }
    
    /// take action from PlaygroundController to restart level
    func restartLevel() {
        sceneBuilder = nil
        sceneBuilder = SceneBuilder()
        matrix = resetMatrix
        indexBlock = []
        temp = 0
        self.viewDidAppear(true)
        self.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sceneBuilder.player.initPlayer()
        
        let gameView = sceneBuilder.getSceneCanvas(level: currentLevel!)
        
        contentWidth.constant = max(gameView.frame.size.width, scrollView.frame.size.width)
        contentHeight.constant = max(gameView.frame.size.height, scrollView.frame.size.height)
        scrollView.layoutIfNeeded()
        
        gameView.center = CGPoint(x: contentWidth.constant / 2, y: contentHeight.constant / 2)
        contentView.addSubview(gameView)
    }
    
    override func viewDidLoad() {
        matrix = currentLevel?.scene?.matrix
        resetMatrix = matrix
        for i in 0..<matrix.characters.count {
            let index = matrix.index(matrix.startIndex, offsetBy: i)
            if matrix[index] == "%" {
                indexBlock.append(i)
            }
        }
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
    
    func getBlockToMove(_ player: UIImageView, x: Int, y: Int) -> Int {
        //        let matrix = currentLevel?.scene?.matrix
        let sceneWidth = currentLevel?.scene?.width?.intValue
        let pos = getPosition(str: matrix!, findElement: "&")
        return pos! + y * sceneWidth! + x
    }
    
    /// check if player is able to move
    func movePlayer(_ player: UIImageView, x: Int, y: Int) {
        //FIX: player go over block, when block is near wall
        //        let matrix = currentLevel?.scene?.matrix
        let sceneWidth = currentLevel?.scene?.width?.intValue
        
        let y_pos = getPosition(str: matrix!, findElement: "&")! / sceneWidth!
        let x_pos = getPosition(str: matrix!, findElement: "&")! - sceneWidth! * y_pos
        
        if isAbleToMove(x: x_pos, y: y_pos, move_x: x, move_y: y) {
            if getSymbol(x: x_pos + x, y: y_pos + y) == "%" {
                if !moveBlock(block: getBlockToMove(player, x: x, y: y), x: x, y: y) {
                    return
                }
            }
            UIView.animate(withDuration: 0.35) {
                player.center.x += CGFloat(x) * player.bounds.size.width
                player.center.y += CGFloat(y) * player.bounds.size.height
                self.swapSymbol(x: x_pos, y: y_pos, x_next: x_pos + x, y_next: y_pos + y)
            }
        }
        
        
        
    }
    
    func isAbleToMove(x: Int, y: Int, move_x: Int, move_y: Int) -> Bool {
        return !(isWall(near: x, y: y, move_x: move_x, move_y: move_y))
    }
    
    /// check if next step is wall (wall near player, wall near block)
    func isWall(near x: Int, y: Int, move_x: Int, move_y: Int) -> Bool {
        return getSymbol(x: x + move_x, y: y + move_y) == "#"
    }
    
    //TODO:
    /// check if next step is block (block near block)
    func isBlock(near x: Int, y: Int, move_x: Int, move_y: Int) -> Bool {
        return getSymbol(x: x + move_x, y: y + move_y) == "%"
    }
    
    func getSymbol(x: Int, y: Int) -> String {
        if let width = currentLevel?.scene?.width?.intValue {
            let index = matrix.index(matrix.startIndex, offsetBy: width * y + x)
            return String(matrix[index])
        }
        return ""
    }
    
    func swapSymbol(x: Int, y: Int, x_next: Int, y_next: Int) {
        if let width = currentLevel?.scene?.width?.intValue {
            var index = matrix.index(matrix.startIndex, offsetBy: width * y + x)
            let temp = matrix[index]
            matrix.remove(at: index)
            matrix.insert("0", at: index)
            matrix.insert(getSymbol(x: x_next, y: y_next).characters.last!, at: index)
            index = matrix.index(matrix.startIndex, offsetBy: width * y + x + 1)
            matrix.remove(at: index)
            index = matrix.index(matrix.startIndex, offsetBy: width * y_next + x_next)
            matrix.remove(at: index)
            matrix.insert(temp, at: index)
        }
    }
    
    func getPosition(str :String, findElement: Character, block_value: Int = 0) -> Int? {
        for (index, value) in Array(str.characters).enumerated() {
            if value == findElement {
                if block_value == 0 {
                    return index
                } else if index == block_value {
                    return index
                }
            }
        }
        return nil
    }
    
    
    /**
     Moves block with direction
     
     - Parameter player: players subview
     - Parameter x: x coordinate
     - Parameter y: y coordinate
     */
    func moveBlock(block: Int, x: Int, y: Int) -> Bool {
        
        let sceneWidth = currentLevel?.scene?.width?.intValue
        var index : String.Index!
        var block_index = -1
        
        for i in 0...block {
            index = matrix?.index((matrix?.startIndex)!, offsetBy: i)
            if String(describing: matrix![index]) == "%" {
                block_index = indexBlock.index(of: i)!
            }
            if i == block {
                index = matrix?.index((matrix?.startIndex)!, offsetBy: i + sceneWidth! * y + x)
                if matrix?[index] == "#" || matrix?[index] == "%" {
                    return false
                }
                temp = indexBlock[block_index]
                indexBlock[block_index] += sceneWidth! * y + x
            }
        }
        
        let y_pos = getPosition(str: matrix!, findElement: "%", block_value: temp)! / sceneWidth!
        let x_pos = (getPosition(str: matrix!, findElement: "%", block_value: temp)! - sceneWidth! * y_pos)
        
        if isAbleToMove(x: x_pos, y: y_pos, move_x: x, move_y: y) {
            
            sceneBuilder.blockCellOut[block_index].isHidden = false
            let num = findBlockIn(center: sceneBuilder.blockCellOut[block_index].center)
            if num != -1 {
                sceneBuilder.blockCellIn[num].isHidden = true
            }
            
            UIView.animate(withDuration: 0.35) {
                self.sceneBuilder.blockCellOut[block_index].center.x += CGFloat(x) * self.sceneBuilder.blockCellOut[block_index].bounds.size.width
                self.sceneBuilder.blockCellOut[block_index].center.y += CGFloat(y) * self.sceneBuilder.blockCellOut[block_index].bounds.size.height
                self.swapSymbol(x: x_pos, y: y_pos, x_next: x_pos + x, y_next: y_pos + y)
                
                index = self.matrix?.index((self.matrix?.startIndex)!, offsetBy: self.indexBlock[block_index])
                
                if self.isBlockOnDot(block: self.sceneBuilder.blockCellOut[block_index]) {
                    self.delay(delay: 0.25) {
                        self.sceneBuilder.blockCellOut[block_index].isHidden = true
                        let num = self.findBlockIn(center: self.sceneBuilder.blockCellOut[block_index].center)
                        if num != -1 {
                            self.sceneBuilder.blockCellIn[num].isHidden = false
                        }
                    }
                }
            }
            
            delay(delay: 1) {
                if self.isFinish() {
                    self.playgroundController?.ifTheEndOfLevel()
                    //                let sender: UIButton
                    //                PlaygroundController.pauseTapped(sender)
                    let alert = UIAlertController(title: "Congratulations", message: String(format: "Score: %.2f",  self.playgroundController!.score), preferredStyle: .alert)
                    var number: Int = self.currentLevel!.order!.intValue + 1
                    if number > 10 {
                        number -= 1
                    }
                    let NextLevelAction = UIAlertAction(title: "Next level", style: .default) { (_) in
                        //                        self.playgroundController.ifTheEndOfLevel()
                        
                        //
                    }
                    let MenuAction = UIAlertAction(title: "Menu", style: .default) { (_) in
                        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
                    }
                    alert.addAction(MenuAction)
                    alert.addAction(NextLevelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            return true
        } else {
            return false
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
    
    func findBlockIn(center: CGPoint) -> Int {
        for block in 0..<sceneBuilder.blockCellIn.count {
            if sceneBuilder.blockCellIn[block].center == center {
                return block
            }
        }
        return -1
    }
    
    func isFinish() -> Bool {
        for block in sceneBuilder.blockCellIn {
            if block.isHidden {
                return false
            }
        }
        _ = navigationController?.popToRootViewController(animated: true)
        return true
    }
}
