//
//  LaunchScreenViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 23.01.17.
//
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    
    @IBOutlet weak var groupName: UILabel!
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var appTitleTop: NSLayoutConstraint!
    
    @IBOutlet weak var groupNameBottom: NSLayoutConstraint!
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        //appTitle.center.y -= view.bounds.height
//        //groupName.center.y += view.bounds.height
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2.0, delay: 1.5, usingSpringWithDamping: 5.0, initialSpringVelocity: 8.0, options: [], animations: {
            if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
                self.groupNameBottom.constant = 150
            } else {
                self.groupNameBottom.constant = 340
            }
            self.view.layoutIfNeeded()
            //self.groupName.center.y -= self.view.bounds.height
            
        }, completion: {(finished:Bool) in
            
            self.whatControllerToOpen()
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
                self.appTitleTop.constant = 200
            } else {
                self.appTitleTop.constant = 250
            }
            
            self.view.layoutIfNeeded()
            //            self.appTitle.center.y += self.view.bounds.height
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
