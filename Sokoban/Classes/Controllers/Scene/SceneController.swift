//
//  SceneController.swift
//  Sokoban
//
//  Created by Dmytro on 1/18/17.
//
//

import UIKit

class SceneController: UIViewController, UIScrollViewDelegate, SceneControllerInterface {
    
    //MARK: Declaration of values
    var currentLevel: Level!
    var playgroundController: PlaygroundController!
    var gameLogic: GameLogic!
    var finishToken = false
    var playView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    /**
     Take action from PlaygroundController to start moving
     
     - Parameter operation: move direction
     */
    func movePlayerButtons(operation: Moves) {
        guard !finishToken else {
            return
        }
        switch operation {
        case .Right:
            gameLogic.animateImage(images: gameLogic.sceneBuilder.player.imageListRight)
            gameLogic.movePlayer(gameLogic.sceneBuilder.playerView!, x: 1, y: 0)
        case .Up:
            gameLogic.animateImage(images: gameLogic.sceneBuilder.player.imageListUp)
            gameLogic.movePlayer(gameLogic.sceneBuilder.playerView!, x: 0, y: -1)
        case .Left:
            gameLogic.animateImage(images: gameLogic.sceneBuilder.player.imageListLeft)
            gameLogic.movePlayer(gameLogic.sceneBuilder.playerView!, x: -1, y: 0)
        case .Down:
            gameLogic.animateImage(images: gameLogic.sceneBuilder.player.imageListDown)
            gameLogic.movePlayer(gameLogic.sceneBuilder.playerView!, x: 0, y: 1)
        }
    }
    
    /**
     Take action from PlaygroundController to restart level
     */
    func restartLevel() {
        gameLogic.sceneBuilder = nil
        gameLogic.sceneBuilder = SceneBuilder()
        gameLogic.matrix = gameLogic.resetMatrix
        gameLogic.indexBlock = []
        gameLogic.temp = 0
        initGame()
    }
    
    /**
     Initialize the game
     */
    func initGame() {
        let gameView = gameLogic.sceneBuilder.getSceneCanvas(level: currentLevel!)
        
        gameLogic.sceneBuilder.player.initPlayer()
        contentWidth.constant = max(gameView.frame.size.width, scrollView.frame.size.width)
        contentHeight.constant = max(gameView.frame.size.height, scrollView.frame.size.height)
        scrollView.layoutIfNeeded()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.gray
        contentView.backgroundColor = UIColor.gray
        
        if UIDevice.current.orientation.isLandscape {
            scrollView.scrollsToTop = true
        } else if UIDevice.current.orientation.isPortrait {
            scrollView.scrollsToTop = true
        }
        
        contentView.addSubview(gameView)
        gameLogic.initBlocks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic = GameLogic()
        gameLogic.currentLevel = currentLevel
        gameLogic.playgroundController = playgroundController
        initGame()
    }
    
    func unwindToMenu() {
        let alert = UIAlertController(title: "Congratulations", message: String(format: "Score: %.2f", self.playgroundController!.score), preferredStyle: .alert)
        let MenuAction = UIAlertAction(title: "Levels", style: .default) { (_) in
            self.performSegue(withIdentifier: "unwindToLevel", sender: self)
        }
        alert.addAction(MenuAction)
        self.present(alert, animated: true, completion: nil)
    }
}
