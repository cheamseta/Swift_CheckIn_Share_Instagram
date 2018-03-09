//
//  ViewController.swift
//  checkIn
//
//  Created by seta cheam on 3/4/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check In and Share";
        self.view.backgroundColor = UIColor(red:0.26,
                                            green:0.26,
                                            blue:0.26,
                                            alpha:1.0);
        
  
        self.logoImageView.downloadedFrom(link: "https://graph.facebook.com/10205416160197106/picture?type=large&return_ssl_resources=1");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showCameraAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imgPicker = UIImagePickerController();
            imgPicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imgPicker.sourceType = .camera;
            imgPicker.allowsEditing = true;
            self.present(imgPicker, animated: true, completion: nil);
        }else {
            let imgPicker = UIImagePickerController();
            imgPicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imgPicker.sourceType = .photoLibrary;
            imgPicker.allowsEditing = true;
            self.present(imgPicker, animated: true, completion: nil);
        }
    }
    
    @IBAction func showMapSaveController(_ sender: UIButton) {
        
        let mapViewController : MapSaveViewController = MapSaveViewController();
        mapViewController.profileImage = self.logoImageView.image;
        
        self.present(mapViewController, animated: true) {}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage;
        self.logoImageView.image = img;
        dismiss(animated: true, completion: nil)
    }
    
}

