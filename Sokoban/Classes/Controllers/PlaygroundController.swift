
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
    
    var currentLevel: Level?
    var isPlaying = false
    var timer = Timer()
    var time = 0
    var movesCount = 0
    var minMoves = 1.0
    var minTime = 1.0
    var timeInSecs = 0.0
    var score = 0.0
    var sceneController: SceneController? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SceneControllerEmbed" {
            sceneController = segue.destination as? SceneController
            sceneController?.currentLevel = currentLevel
            sceneController?.playgroundController = self
        }
    }
    
    @IBAction func MoveAction(_ sender: UIButton) {
        sceneController?.movePlayerButtons(operation: Moves(rawValue: sender.tag)!)
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
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        
        if isPlaying {
            timer.invalidate()
            isPlaying = false
        }
        
    }
    
    override func viewDidLoad() {
        
        print(currentLevel?.name ?? "ERROR!!!")
    }
    
    func ifTheEndOfLevel() {
        if isPlaying {
            timer.invalidate()
            isPlaying = false
        }
        calculateScore()
        PlayersProvider.setLevelScoreForCurrentPlayer(level: currentLevel!, score: score)
    }
    
    func calculateScore() {
        score = ((minTime/timeInSecs)*(minMoves/Double(movesCount))) * 100
    }
    
    func updateTime() {
        time += 1
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        timeLabel.text = String(format:"%02i:%02i", minutes, seconds)
        timeInSecs = Double(minutes * 60 + seconds)
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        if isPlaying {
            timer.invalidate()
            isPlaying = false
        }
        time = 0
        movesCount = 0
        timer.invalidate()
        timeLabel.text = String("00:00")
        stepsCountLabel.text = String(0)
        sceneController?.restartLevel()
        
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
