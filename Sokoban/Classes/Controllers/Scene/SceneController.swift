//
//  SceneController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class SceneController: UIViewController {
    
    @IBOutlet weak var animationBtn: UIButton!
    var wallView = WallCell(frame: CGRect(x: 10, y: 20, width: 60, height: 60))
    var imageView: UIImageView!
    
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
            changePlayerPosition(imageView, x: 1, y: 0)
        case "👆":
            animateImage(type: player.imageListUp)
            changePlayerPosition(imageView, x: 0, y: -1)
        case "👈":
            animateImage(type: player.imageListLeft)
            changePlayerPosition(imageView, x: -1, y: 0)
        case "👇🏿":
            animateImage(type: player.imageListDown)
            changePlayerPosition(imageView, x: 0, y: 1)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.initPlayer()
        self.view.addSubview(wallView)
        let image = UIImage(named: "down1")
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 10, y: 150, width: 60, height: 60)
        self.view.addSubview(imageView)
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
    
    func changePlayerPosition(_ player: UIImageView, x: Int, y: Int) {
        if wallView.center.x == (player.center.x + CGFloat(x) * player.bounds.size.width) && wallView.center.y == (player.center.y + CGFloat(y) * player.bounds.size.height) {
            return
        }
        UIView.animate(withDuration: 0.35) {
            player.center.x += CGFloat(x) * player.bounds.size.width
            player.center.y += CGFloat(y) * player.bounds.size.height
        }
    }
}
