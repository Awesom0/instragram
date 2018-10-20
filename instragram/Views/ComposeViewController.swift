//
//  ComposeViewController.swift
//  instragram
//
//  Created by Felipe De La Torre on 10/19/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import MBProgressHUD

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var selectPhotoImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    var photoForPost: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getPhoto(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        // choose camera if have one, else choose from library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    //delegate method
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectPhotoImageView.image = originalImage
        // change photoForPost to true if there is an image
        photoForPost = true
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backHomeSegue", sender: nil)
    }
    
    
    @IBAction func onShare(_ sender: Any) {
        let caption = captionTextField.text ?? ""
        let image = selectPhotoImageView.image
    
        if(!photoForPost){
            print("no photo selected")
            //display message
            let alertController = UIAlertController(title: "No Photo Selected!", message: "Please choose a photo to post.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
            }
            return;
            
        }
        Post.postUserImage(image: image, withCaption: caption){ (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.performSegue(withIdentifier: "backHomeSegue", sender: nil)
        
    }
    //resizing
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width : newSize.width, height : newSize.height))
        resizeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    @IBAction func onSelectAPhoto(_ sender: Any) {
        self.getPhoto()
        
    }
    
}
