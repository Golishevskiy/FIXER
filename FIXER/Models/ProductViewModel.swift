//
//  ProductViewModel.swift
//  FIXER
//
//  Created by Per Pert on 3/31/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class ProductViewModel {
    
    let product: Product
    var cartStatus: Bool
    var image: UIImage?
    
    private var imageDownloadHandler: ((UIImage?) -> ())?
    
    init(product: Product) {
        self.product = product
        self.cartStatus = false
    }
    
    func loadImage(_ completion: @escaping (UIImage?) -> ()) {
        if image != nil {
            return
        }
        
        imageDownloadHandler = completion
        
        if let firstImagePath = product.images.first,
            let firstImageUrl = URL(string: firstImagePath) {
            DispatchQueue.global(qos: .background).async { [weak self] in
                if let imagedData = try? Data(contentsOf: firstImageUrl) {
                    DispatchQueue.main.async {
                        let image = UIImage(data: imagedData)
                        self?.image = image
                        self?.imageDownloadHandler?(image)
                    }
                }
            }
        }
    }
    
    func cancelImageDownload() {
        self.imageDownloadHandler = nil
    }
}
