//
//  MapSaveViewController.swift
//  checkIn
//
//  Created by seta cheam on 3/4/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit
import CoreLocation

class MapSaveViewController: ViewController, CLLocationManagerDelegate, UIDocumentInteractionControllerDelegate {
    
    public var profileImage : UIImage!
    
    @IBOutlet var renderView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var mapImageView: UIImageView!
    
     var locationManager:CLLocationManager!
    
    var yourImage: UIImage?
    var documentController: UIDocumentInteractionController!
    
    
    var googleStaticMapUrl : String = "";
    
    override func viewDidLoad() {
        self.initView();
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.getCurrentLocation();
    }
    
    func initView () {
        self.mapImageView.downloadedImg(link: self.googleStaticMapUrl);
        self.mapImageView.borderMe(borderSize: 15.0);
        self.mapImageView.shadowMe();
        
        
        self.profileImageView.roundMe();
        self.profileImageView.image = self.profileImage;
        
    }
    
    @IBAction func reloadLocation(_ sender: Any) {
          self.getCurrentLocation();
    }
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)");
        
        self.googleStaticMapUrl = "https://maps.googleapis.com/maps/api/staticmap?center=\(locValue.latitude),\(locValue.longitude)&zoom=18&size=600x600&maptype=roadmap&key=YOURKEY"
        self.initView();
    }
    
    func saveImg () -> UIImage {
        let render = UIGraphicsImageRenderer(size: self.renderView.bounds.size);
        let img = render.image { (context) in
            self.renderView.drawHierarchy(in: self.renderView.bounds, afterScreenUpdates: true);
        }
        
        return img;
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    @IBAction func shareToInstagram(_ sender: Any) {
        self.yourImage = self.saveImg();
        self.shareToInstagram();
//        UIImageWriteToSavedPhotosAlbum(self.yourImage!, nil, nil, nil);
    }
    
    func shareToInstagram() {
        let instagramURL = NSURL(string: "instagram://app")
        
        if (UIApplication.shared.canOpenURL(instagramURL! as URL)) {
            
            if let imageData = UIImageJPEGRepresentation(yourImage!, 100) {
                let filename = getDocumentsDirectory().appendingPathComponent("instagram.igo")
    
                try? imageData.write(to: filename)
    
                let captionString = "caption"
                
                self.documentController = UIDocumentInteractionController(url: filename as URL)
                
                self.documentController.delegate = self
                
                self.documentController.uti = "com.instagram.exlusivegram"
                
                self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstagramCaption" as NSCopying)
                self.documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
                
                
            }
            
        } else {
            print(" Instagram isn't installed ")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
