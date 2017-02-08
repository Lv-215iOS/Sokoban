//
//  FirstLaunchViewController.swift
//  Sokoban
//
//  Created by pasik_01 on 19.01.17.
//
//
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}

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
        if addPlayerTextField.text == "" {
            let alert = UIAlertController(title: "No player name", message: "Please, enter player name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if imageDisplay.image != nil {
            PlayersProvider.addPlayerWith(name: addPlayerTextField.text!, score: 0.0,  photo:imageDisplay.image!)
            PlayersProvider.setCurrentPlayerWith(name: addPlayerTextField.text!)
        } else {
            PlayersProvider.addPlayerWith(name: addPlayerTextField.text!, score: 0.0,  photo:#imageLiteral(resourceName: "down1.png"))
            PlayersProvider.setCurrentPlayerWith(name: addPlayerTextField.text!)
        }
        
        if defaults.string(forKey: "isPlayerAlreadyCreated") != nil{
            _ = navigationController?.popViewController(animated: true)
            
        } else {
            defaults.set(true, forKey: "isPlayerAlreadyCreated")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func PhotoLibraryAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func CameraAction(_ sender: UIButton) {
         if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
         } else {
            let ac = UIAlertController(title: "Source Not Available", message: "The camera is not available.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageDisplay.image = info[UIImagePickerControllerOriginalImage] as! UIImage? ;
        imageDisplay.image = resizeImage(image: imageDisplay.image!, newWidth: 200)
        dismiss(animated: true, completion: nil)
        
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(newWidth, newHeight))
        image.draw(in: CGRect(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstLaunchViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        self.imageDisplay.layer.cornerRadius = self.imageDisplay.frame.size.width / 2;
        self.imageDisplay.clipsToBounds = true;
    }
    
}
