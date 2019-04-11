//
//  Cart.swift
//  FIXER
//
//  Created by Per Pert on 3/28/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation
import UIKit

class Cart {
    static let shared = Cart()
    var cartArrayItem: [ProductInCart] = []
    
    func addItemToCart(item: ProductViewModel) {
        cartArrayItem.append(ProductInCart(nameItem: item.product.title.ru,
                                           priceItem: Int(item.product.price),
                                           countItem: 1,
                                           articleItem: item.product.article,
                                           preViewImage: item.image ?? UIImage(named: "rabbit")!))
    }
}

class ProductInCart {
    let name: String
    let price: Int
    var count: Int
    let article: String
    let image: UIImage
    
    init(nameItem: String, priceItem: Int, countItem: Int, articleItem: String, preViewImage: UIImage) {
        name = nameItem
        price = priceItem
        count = countItem
        article = articleItem
        image = preViewImage
    }
}

