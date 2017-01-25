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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appTitle.center.y -= view.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5, animations: {
            
            self.appTitle.center.y += self.view.bounds.height
            
            
        }, completion: {(finished:Bool) in
            
            self.whatControllerToOpen()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    let defaults = UserDefaults.standard
    func whatControllerToOpen()
    {
        
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            print("App already launched")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: FirstLaunchViewController = storyboard.instantiateViewController(withIdentifier: "firstViewController") as! FirstLaunchViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
}
