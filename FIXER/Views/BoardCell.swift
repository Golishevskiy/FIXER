//
//  BoardCell.swift
//  FIXER
//
//  Created by Per Pert on 23.09.2019.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class BoardCell: UITableViewCell {
    
    var viewModel: ProductViewModel?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productInfoLabel: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var UAHLabel: UILabel!
    @IBOutlet weak var presenceLabel: UILabel!
    
    
    func fill(_ productViewModel: ProductViewModel) {
        self.viewModel = productViewModel
        self.productNameLabel.text = productViewModel.product.title.ua
        self.productImage.image = productViewModel.image ?? UIImage(named: "noPhoto")
        self.productInfoLabel.text = Int(productViewModel.product.price * 27).description
        
        if productViewModel.product.presence.value.ua == "В наявності" {
            self.presenceLabel.textColor = .green
        } else {
            self.presenceLabel.textColor = .red
        }
        self.presenceLabel.text = productViewModel.product.presence.value.ua
        
        viewCell.layer.cornerRadius = 10
        viewCell.layer.shadowColor = UIColor.gray.cgColor
        viewCell.layer.shadowOpacity = 0.3
        viewCell.layer.shadowOffset = CGSize.zero
        viewCell.layer.shadowRadius = 6
        selectionStyle = .none
        
//        viewCell.layer.cornerRadius = 15
//        viewCell.layer.masksToBounds = true
//        viewCell.layer.shadowRadius = 20
//        viewCell.layer.shadowOffset = .zero
//        viewCell.layer.shadowOpacity = 0.2
//        viewCell.layer.shadowColor = UIColor.black.cgColor
//        viewCell.backgroundColor = .red
        
        //        layer.cornerRadius = 15
        //        layer.masksToBounds = true
        //        layer.shadowOffset = .zero
        //        layer.shadowOpacity = 0.2
        //        layer.shadowRadius = 5
        //        layer.shadowColor = UIColor.black.cgColor
        //        layer.masksToBounds = false
        
        productViewModel.loadImage { [weak self] (loadedImage) in
            self?.productImage.image = loadedImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImage.image = nil
        self.viewModel?.cancelImageDownload()
        self.viewModel = nil
    }
    
}
