//
//  ImageSlider.swift
//  FIXER
//
//  Created by Per Pert on 8/31/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation
import UIKit

class ImageSlider: UICollectionViewCell {
    
    
    func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
            guard let url = URL(string: urlString) else {
    return closure(nil)
            }
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    print("error: \(String(describing: error))")
                    return closure(nil)
                }
                guard response != nil else {
                    print("no response")
                    return closure(nil)
                }
                guard data != nil else {
                    print("no data")
                    return closure(nil)
                }
                DispatchQueue.main.async {
                    closure(UIImage(data: data!))
                }
            }
        task.resume()
        }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    func setupCell(image: String) {
        getImageFromWeb(image) { (image) in
            self.myImageView.image = image
        }
    }
}
