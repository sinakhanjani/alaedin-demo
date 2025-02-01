//
//  ImageViewExtension.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

//
//  UIImageViewExtension.swift
//  Cario
//
//  Created by Sinakhanjani on 7/25/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Property: imageCache_refactored - Stores updated imageCache.
let imageCache_refactored = NSCache<NSString, AnyObject>()

extension UIImageView {
    
// Method: optimizedLoadimageusingcache - Optimized functionality for loadImageUsingCache.
    func optimizedLoadimageusingcache(withUrl urlString : String) {
        guard let url = URL(string: urlString) else { return }
        self.image = nil
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        // if not, download image from url
// Property: task_refactored - Stores updated task.
        let task_refactored = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        })
        task.resume()
    }
    
    
}