//
//  LaunchScreenViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 23.01.17.
//
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupNameCenter: NSLayoutConstraint!
    @IBOutlet weak var appTitleCenter: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2.0, delay: 1.5, usingSpringWithDamping: 5.0, initialSpringVelocity: 8.0, options: [], animations: {
            self.groupNameCenter.constant = 20
            self.view.layoutIfNeeded()
            
        }, completion: {(finished:Bool) in
            
            self.whatControllerToOpen()
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            
            self.appTitleCenter.constant = 0
            self.view.layoutIfNeeded()
            self.appTitle.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.appTitle.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            
            AudioPlayer.sharedInstance.backgroundMusic()
            
            let musicIsPlaying = UserDefaults.standard.bool(forKey: "musicIsPlaying")
            
            if musicIsPlaying == false {
                AudioPlayer.sharedInstance.stopMusic()
            } else {
                AudioPlayer.sharedInstance.playMusic()
            }
        } else {
            AudioPlayer.sharedInstance.backgroundMusic()
        }
        
    }
    
    func whatControllerToOpen()
    {
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil && PlayersProvider.getPlayers()!.count != 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: FirstLaunchViewController = storyboard.instantiateViewController(withIdentifier: "firstViewController") as! FirstLaunchViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
}
