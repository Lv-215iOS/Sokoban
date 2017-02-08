//
//  SettingsViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 19.01.17.
//
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var soundSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (AudioPlayer.sharedInstance.backgroundMusicAudioPlayer?.isPlaying)! {
            soundSwitch.isOn = true
        } else {
            soundSwitch.isOn = false
        }
    }
    
    /// turns background on/off
    @IBAction func switchSoundChanged(_ sender: UISwitch) {
        if  sender.isOn {
            AudioPlayer.sharedInstance.playMusic()
        } else {
            AudioPlayer.sharedInstance.stopMusic()
        }
    }
    
    /// resets current player scores
    @IBAction func resetScoresButtonTapped(_ sender: UIButton) {
        
        sender.highlight()
        
        let alert = UIAlertController(title: "Score", message: "Are you sure you want to reset all scores?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let currentPlayer = PlayersProvider.currentPlayer
            PlayersProvider.resetScoreFor(player: currentPlayer!)        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        alert.addAction(OKAction)
        alert.addAction(CancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }    
}
