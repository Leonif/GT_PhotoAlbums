//
//  UIImageView+Extensions.swift
//  GT_PhotoAlbums
//
//  Created by Leonid Nifantyev on 11/24/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

final class CustomKey : NSObject {
    let string: String
    
    init(string: String) {
        self.string = string
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CustomKey else {
            return false
        }
        return string == other.string
    }
    
    override var hash: Int {
        return string.hashValue
    }
}

let imageCashe = NSCache<CustomKey, UIImage>()

extension UIImageView {
    func downloadImage(for urlString: String) {
        
        image = nil
        
        if let imageFromCashe = imageCashe.object(forKey: CustomKey(string: urlString)) {
            self.image = imageFromCashe
            return
        }
        
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCashe = UIImage(data: data!)
                imageCashe.setObject(imageToCashe!, forKey: CustomKey(string: urlString))
                
                self.image = imageToCashe
            }
            
        }.resume()
    }
}
