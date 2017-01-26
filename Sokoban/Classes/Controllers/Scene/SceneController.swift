//
//  SceneController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class SceneController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var animationBtn: UIButton!
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
        case "👆":
            animateImage(type: player.imageListUp)
        case "👈":
            animateImage(type: player.imageListLeft)
        case "👇🏿":
            animateImage(type: player.imageListDown)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.initPlayer()
    }
    
    func animateImage(type: [UIImage]) {
        imageView.animationImages = type
        imageView.animationDuration = 0.35
        imageView.startAnimating()
        delay(delay: 0.35) {
            self.imageView.stopAnimating()
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
}
