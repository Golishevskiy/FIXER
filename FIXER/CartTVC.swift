//
//  CartTVC.swift
//  FIXER
//
//  Created by Per Pert on 3/29/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class CartTVC: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var productInCart: ProductInCart?
    
    @IBAction func changeCountItem(_ sender: UIStepper) {
        guard let productInCart = productInCart else { return }
        Cart.shared.changeCount(productInCart, count: Int(sender.value))
    }

    func fillIn(_ product: ProductInCart) {
        productInCart = product
        nameLabel.text = product.name
        priceLabel.text = String(product.price)
        countLabel.text = String(product.count)
        cartImageView.image = product.image
        stepper.value = Double(product.count)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productInCart = nil
    }
}
