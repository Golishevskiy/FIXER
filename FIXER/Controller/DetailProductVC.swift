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
        self.title = "Детальніше"
        CheckProductInCartAfterReloadMenu(productInCart: Cart.shared.cartArrayItem, slectedProduct: item!)
        productImageView.image = item?.image ?? UIImage(named: "noPhoto")
        nameLabel.text = item?.product.title.ru
        guard let price = item?.product.price else { return }
        priceLabel.text = String(Int(price) * 27)
        guard let descr = item?.product.description.ru else { return }
        textViewDescription.attributedText = try? NSAttributedString(htmlString: descr)
        textViewDescription.isEditable = false
        
    }
    
    @IBAction func addToCart(_ bayButton: UIButton) {
        guard let itemProd = item else { return }
        Cart.shared.addItemToCart(item: itemProd)
        bayButton.setTitle("в корзине", for: .normal)
        let textColorButton = UIColor(red: 0.6, green: 0.2, blue: 0.5, alpha: 1)
        bayButton.setTitleColor(textColorButton, for: .normal)
        bayButton.isEnabled = false
        item?.cartStatus = true
    }
    
    func CheckProductInCartAfterReloadMenu(productInCart: [ProductInCart], slectedProduct: ProductViewModel) {
        for i in productInCart {
            if String(i.article) == item?.product.article {
                bayButton.isEnabled = false
                bayButton.setTitle("в корзине", for: .normal)
                let textColorButton = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
                bayButton.setTitleColor(textColorButton, for: .normal)
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
