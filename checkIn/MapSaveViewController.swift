//
//  MapSaveViewController.swift
//  checkIn
//
//  Created by seta cheam on 3/4/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class MapSaveViewController: ViewController {
    
    public var profileImage : UIImage!
    
    @IBOutlet var renderView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var mapImageView: UIImageView!
    
    let googleStaticMapUrl : String = "https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=16&size=600x600&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&scale=2&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyDo1lKPO63zmTxQ03_TseIhk6kMYFtlACs"
    
    override func viewDidLoad() {
        self.initView();
    }
    
    func initView () {
        self.mapImageView.downloadedImg(link: self.googleStaticMapUrl);
        self.mapImageView.borderMe(borderSize: 15.0);
        self.mapImageView.shadowMe();
        
        
        self.profileImageView.roundMe();
        self.profileImageView.image = self.profileImage;
        
    }
    
    func saveImg () -> UIImage {
        let render = UIGraphicsImageRenderer(size: self.renderView.bounds.size);
        let img = render.image { (context) in
            self.renderView.drawHierarchy(in: self.renderView.bounds, afterScreenUpdates: true);
        }
        
        return img;
    }
    
    @IBAction func shareToInstagram(_ sender: Any) {
        let img = self.saveImg();
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    }
    
    
    
}
