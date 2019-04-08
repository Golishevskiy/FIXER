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
        if cartArrayItem.count == 0 {
            let oneItem = ProductInCart(nameItem: item.product.title.ru,
                                        priceItem: Int(item.product.price),
                                        countItem: 1,
                                        articleItem: Int(item.product.article)!,
                                        preViewImage: item.image ?? UIImage(named: "rabbit")!)
            cartArrayItem.append(oneItem)
        } else {
            countItem(item: item)
        }
    }
    
    func countItem(item: ProductViewModel) {
        let count = cartArrayItem.count
        for i in 0..<count {
            if Int(item.product.article) == cartArrayItem[i].article {
                cartArrayItem[i].count += 1
            } else {
                let oneItem = ProductInCart(nameItem: item.product.title.ru,
                                            priceItem: Int(item.product.price),
                                            countItem: 1,
                                            articleItem: Int(item.product.article)!,
                                            preViewImage: item.image ?? UIImage(named: "rabbit")!)
                cartArrayItem.append(oneItem)
            }
        }
    }
}

class ProductInCart {
    let name: String
    let price: Int
    var count: Int
    let article: Int
    let image: UIImage
    
    init(nameItem: String, priceItem: Int, countItem: Int, articleItem: Int, preViewImage: UIImage) {
        name = nameItem
        price = priceItem
        count = countItem
        article = articleItem
        image = preViewImage
    }
}

