//
//  MenuController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var userListButton: UIButton!
    
    /// to open playersViewController
    @IBAction func userListButtonTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var menuPlayButton: UIButton!
    
    /// to open LevelsViewController
    @IBAction func menuPlayButtonTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var menuLeaderboardButton: UIButton!
    
    /// to open leaderboardViewController
    @IBAction func menuLeaderboardButtonTapped(_ sender: UIButton) {
    }

    @IBOutlet weak var menuSettingsButton: UIButton!
   
    /// to open settingsViewController
    @IBAction func menuSettingsButtonTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var menuAboutButton: UIButton!
    
    /// to open aboutViewController
    @IBAction func menuAboutButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }
    
    func configureButton() {
        menuPlayButton.layer.cornerRadius = 0.5 * menuPlayButton.bounds.size.width
        menuPlayButton.clipsToBounds = true
        
        menuLeaderboardButton.layer.cornerRadius = 0.5 * menuPlayButton.bounds.size.width
        menuLeaderboardButton.clipsToBounds = true
        
        menuSettingsButton.layer.cornerRadius = 0.5 * menuPlayButton.bounds.size.width
        menuSettingsButton.clipsToBounds = true
        
        menuAboutButton.layer.cornerRadius = 0.5 * menuPlayButton.bounds.size.width
        menuAboutButton.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        configureButton()
    }
    
}
