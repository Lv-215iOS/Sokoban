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
    
    @IBAction func animationBtnClicked(_ sender: UIButton) {
        switch sender.currentTitle! {
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
}
