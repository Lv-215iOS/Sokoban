//
//  FirstLaunchViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 19.01.17.
//
//

import UIKit

class FirstLaunchViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var addPlayerTextField: UITextField!
    
    @IBOutlet weak var createNewPlayerButton: UIButton!
    let defaults = UserDefaults.standard
    
    
    /// to open MenuViewController and change nickname
    @IBAction func createNewPlayerButtonTapped(_ sender: UIButton) {
        PlayersProvider.addPlayerWith(name: addPlayerTextField.text!, score: 0.0, levelsScores: [0.0], photo:imageDisplay.image!)
        
        if defaults.string(forKey: "isPlayerAlreadyCreated") != nil{
            _ = navigationController?.popViewController(animated: true)
            
        } else {
            defaults.set(true, forKey: "isPlayerAlreadyCreated")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func CameraAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageDisplay.image = info[UIImagePickerControllerOriginalImage] as! UIImage?; dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
