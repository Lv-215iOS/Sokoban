//
//  PlaygroundController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class PlaygroundController: UIViewController {
    
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
        let alert = UIAlertController(title: "Back to menu", message: "Quit game?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        alert.addAction(OKAction)
        alert.addAction(CancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
