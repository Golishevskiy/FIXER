//
//  ProductCell.swift
//  FIXER
//
//  Created by Per Pert on 3/15/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var nameProductCell: UILabel!
    
    var viewModel: ProductViewModel?
    
    func fill(_ productViewModel: ProductViewModel) {
        self.viewModel = productViewModel
        self.nameProductCell.text = productViewModel.product.title.ua
        self.imageViewProduct.image = productViewModel.image ?? UIImage(named: "rabbit")
        
        productViewModel.loadImage { [weak self] (loadedImage) in
            self?.imageViewProduct.image = loadedImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageViewProduct.image = nil
        self.viewModel?.cancelImageDownload()
        self.viewModel = nil
    }
}
