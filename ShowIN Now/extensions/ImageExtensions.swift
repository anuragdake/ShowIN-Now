//
//  ImageExtensions.swift
//  ShowIN Now
//
//  Created by Anurag Dake on 03/03/18.
//  Copyright © 2018 Anurag Dake. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        guard let url = URL(string: urlString) else{
            return
        }
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let imageData = data, let image = UIImage(data: imageData) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}
