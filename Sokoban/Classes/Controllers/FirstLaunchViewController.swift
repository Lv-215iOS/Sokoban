//
//  FirstLaunchViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 19.01.17.
//
//

import UIKit

class FirstLaunchViewController: UIViewController {

   
    @IBOutlet weak var addPlayerTextField: UITextField!
    
    @IBOutlet weak var createNewPlayerButton: UIButton!
    
   
   
    /// to open MenuViewController and change nickname
    @IBAction func createNewPlayerButtonTapped(_ sender: UIButton) {
        PlayersProvider.addPlayerWith(name: addPlayerTextField.text!, score: 0.0, levelsScores: [0.0])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
