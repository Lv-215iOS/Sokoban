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
    var playerView: UIImageView!
    
    var player = PlayerCell()
    var levels = LevelsProvider.getLevels()
    
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
    func getLevel(_ level: Int) -> (width: NSNumber?, height: NSNumber?, matrix: String?) {
        let levelScene = levels?[level].scene
        let levelHeight = levelScene?.height
        let levelWidth = levelScene?.width
        let levelMatrix = levelScene?.matrix
        return (levelWidth, levelHeight, levelMatrix)
    }
    
    func changePlayerPosition(_ player: UIImageView, x: Int, y: Int) {
        for wall in wallViewArray {
            if wall.center.x == (player.center.x + CGFloat(x) * player.bounds.size.width) && wall.center.y == (player.center.y + CGFloat(y) * player.bounds.size.height) {
                return
            }
        }
        UIView.animate(withDuration: 0.35) {
            player.center.x += CGFloat(x) * player.bounds.size.width
            player.center.y += CGFloat(y) * player.bounds.size.height
        }
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
}
