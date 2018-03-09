//
//  UIImage+link.swift
//  checkIn
//
//  Created by seta cheam on 3/9/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image;
            }
            }.resume()
    }
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { return }
        self.layer.borderWidth = 5;
        self.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor;
        self.layer.cornerRadius = self.bounds.width / 2;
        self.clipsToBounds = true;
        downloadedFrom(url: url);
    }
    
    func downloadedImg(link: String) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url)
    }
    
    func shadowMe(){
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowColor = UIColor(white: 0, alpha: 0.8).cgColor;
        self.layer.shadowRadius = 15;
        self.layer.shadowOffset = CGSize(width: 5, height: 5);
    }
    
    func borderMe(borderSize : CGFloat) {
        self.layer.borderWidth = borderSize;
        self.layer.borderColor = UIColor(white:1, alpha:1).cgColor;
    }
    
    func roundMe() {
        self.layer.cornerRadius = self.bounds.width / 2;
        self.clipsToBounds = true;
    }
    
}
