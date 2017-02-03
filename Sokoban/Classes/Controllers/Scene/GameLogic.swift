//
//  GameLogic.swift
//  Sokoban
//
//  Created by Dmytro on 2/2/17.
//
//

import UIKit

class GameLogic: SceneController {
    
    //MARK: Declaration of values
    var resetMatrix: String!
    var matrix: String!
    var indexBlock: [Int] = []
    var temp = 0
    var sceneBuilder: SceneBuilder! = SceneBuilder()
    
    /**
     Initialize blocks
     */
    func initBlocks() {
        matrix = currentLevel?.scene?.matrix
        resetMatrix = matrix
        for i in 0..<matrix.characters.count {
            let index = matrix.index(matrix.startIndex, offsetBy: i)
            if matrix[index] == "%" {
                indexBlock.append(i)
            }
        }
    }
    
    /**
     Animate player moves
     
     - Parameter images: array of UIImage
     */
    func animateImage(images: [UIImage]) {
        sceneBuilder.playerView?.animationImages = images
        sceneBuilder.playerView?.animationDuration = 0.35
        sceneBuilder.playerView?.startAnimating()
        delay(delay: 0.35) {
            self.sceneBuilder.playerView?.stopAnimating()
        }
    }
    
    /**
     Delay
     
     - Parameter delay: time in ms
     - Parameter closure: empty closure
     */
    func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    /**
     Move block
     
     - Parameter player: UIImageView
     - Parameter x: player coordinate
     - Parameter y: player coordinate
     
     - Return: player position
     */
    func getBlockToMove(_ player: UIImageView, x: Int, y: Int) -> Int {
        let sceneWidth = currentLevel?.scene?.width?.intValue
        let pos = getPosition(str: matrix!, findElement: "&")
        return pos! + y * sceneWidth! + x
    }
    
    /**
     Check if player is able to move
     
     - Parameter player: UIImageView
     - Parameter x: player coordinate on x axes
     - Parameter y: player coordinate on y axes
     
     - Return: player position
     */
    func movePlayer(_ player: UIImageView, x: Int, y: Int) {
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
    
    /**
     Check if view is able to move
     
     - Parameter x: view coordinate on x axes
     - Parameter y: view coordinate on y axes
     - Parameter move_x: view shift on x axes
     - Parameter move_y: view shift on y axes
     
     - Return: true or false
     */
    func isAbleToMove(x: Int, y: Int, move_x: Int, move_y: Int) -> Bool {
        return !(isWall(near: x, y: y, move_x: move_x, move_y: move_y))
    }
    
    /**
     Check if next step is wall
     
     - Parameter x: view coordinate on x axes
     - Parameter y: view coordinate on y axes
     - Parameter move_x: view shift on x axes
     - Parameter move_y: view shift on y axes
     
     - Return: true or false
     */
    func isWall(near x: Int, y: Int, move_x: Int, move_y: Int) -> Bool {
        return getSymbol(x: x + move_x, y: y + move_y) == "#"
    }
    
    /**
     Check if next step is block
     
     - Parameter x: view coordinate on x axes
     - Parameter y: view coordinate on y axes
     - Parameter move_x: view shift on x axes
     - Parameter move_y: view shift on y axes
     
     - Return: true or false
     */
    func isBlock(near x: Int, y: Int, move_x: Int, move_y: Int) -> Bool {
        return getSymbol(x: x + move_x, y: y + move_y) == "%"
    }
    
    /**
     Gets symbol from matrix
     
     - Parameter x: symbol coordinate on x axes
     - Parameter y: symbol coordinate on y axes
     
     - Return: symbol
     */
    func getSymbol(x: Int, y: Int) -> String {
        if let width = currentLevel?.scene?.width?.intValue {
            let index = matrix.index(matrix.startIndex, offsetBy: width * y + x)
            return String(matrix[index])
        }
        return ""
    }
    
    /**
     Swap symbols in matrix
     
     - Parameter x: view coordinate on x axes
     - Parameter y: view coordinate on y axes
     - Parameter move_x: view shift on x axes
     - Parameter move_y: view shift on y axes
     */
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
    
    /**
     Gets symbol position from matrix
     
     - Parameter str: matrix
     - Parameter findElement: symbol
     - Parameter block value: block_out order
     
     - Return: index position
     */
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
     
     - Parameter block: block index
     - Parameter x: x coordinate
     - Parameter y: y coordinate
     
     - Return: true or false
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
                    self.playgroundController.sceneController?.unwindToMenu()
                }
            }
            return true
        } else {
            return false
        }
    }
    
    /**
     Check if block is on cell
     
     - Parameter block: temporary block_out
     
     - Return: true or false
     */
    func isBlockOnDot(block: BlockCellOut) -> Bool {
        for dot in sceneBuilder.dotCell {
            if block.center.x == dot.center.x && block.center.y == dot.center.y {
                return true
            }
        }
        return false
    }
    
    /**
     Search block_in
     
     - Parameter center: center of serching clock_in
     
     - Return: index of block_in
     */
    func findBlockIn(center: CGPoint) -> Int {
        for block in 0..<sceneBuilder.blockCellIn.count {
            if sceneBuilder.blockCellIn[block].center == center {
                return block
            }
        }
        return -1
    }
    
    /**
     Check if game is finished
     
     - Return: true or false
     */
    func isFinish() -> Bool {
        for block in sceneBuilder.blockCellIn {
            if block.isHidden {
                return false
            }
        }
        _ = navigationController?.popViewController(animated: true)
        return true
    }
}
