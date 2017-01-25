//
//  PlaygroundController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class PlaygroundController: UIViewController {
    
    @IBOutlet weak var movesCountLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var stepsCountLabel: UILabel!
    
    
    var isPlaying = false
    var timer = Timer()
    var time = 0
    var movesCount = 0
    
    
    var sceneController: SceneController? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SceneController" {
            sceneController = segue.destination as? SceneController
        }
    }
    
    @IBAction func MoveAction(_ sender: UIButton) {
        sceneController?.animatePlayer(title: sender.currentTitle!)
    }
    
    
    @IBAction func backToMenu(_ sender: UIButton) {
        let alert = UIAlertController(title: "Back to menu", message: "Are you sure you want to quit the game?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        alert.addAction(OKAction)
        alert.addAction(CancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        
        if isPlaying {
            timer.invalidate()
            isPlaying = false
        }
        ///TODO:joystick becomes unable
    }
    
    func updateTime() {
        time += 1
        timeLabel.text = String(time)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        time = 0
        movesCount = 0
        timer.invalidate()
        timeLabel.text = String(0)
        stepsCountLabel.text = String(0)
        ///TODO:player respawns,view redraws
    }
    
    @IBAction func moveActionTapped(_ sender: UIButton) {
        movesCount += 1
        movesCountLabel.text = String(movesCount)
        if !isPlaying {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PlaygroundController.updateTime), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
}
