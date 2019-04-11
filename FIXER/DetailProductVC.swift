//
//  DetailProductVC.swift
//  FIXER
//
//  Created by Per Pert on 3/22/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Foundation

class DetailProductVC: UIViewController {
    var item: ProductViewModel?
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var bayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CheckProductInCartAfterReloadMenu(productInCart: Cart.shared.cartArrayItem, slectedProduct: item!)
        
        productImageView.image = item?.image
        
        nameLabel.textColor = UIColor.blue
        nameLabel.text = item?.product.title.ua
        guard let price = item?.product.price else { return }
        priceLabel.text = String(price * 28)
        guard let descr = item?.product.description.ru else { return }
        textViewDescription.attributedText = try? NSAttributedString(htmlString: descr)
        
    }
    
    @IBAction func addToCart(_ bayButton: UIButton) {
        guard let itemProd = item else { return }
        Cart.shared.addItemToCart(item: itemProd)
        bayButton.setTitle("в корзине", for: .normal)
        bayButton.isEnabled = false
        item?.cartStatus = true
    }
    
    func CheckProductInCartAfterReloadMenu(productInCart: [ProductInCart], slectedProduct: ProductViewModel) {
        for i in productInCart {
            if String(i.article) == item?.product.article {
                print("This product in cart")
                bayButton.isEnabled = false
                bayButton.setTitle("в корзине", for: .normal)
            }
        }
    }
}

extension NSAttributedString {
    convenience init(htmlString html: String) throws {
        try self.init(data: Data(html.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
    }
}
