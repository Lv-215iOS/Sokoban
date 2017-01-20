//
//  PlaygroundController.swift
//  Sokoban
//
//  Created by admin on 1/18/17.
//
//

import UIKit

class PlaygroundController: UIViewController {
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
