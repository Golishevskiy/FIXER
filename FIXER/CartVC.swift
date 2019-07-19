//
//  CartVC.swift
//  FIXER
//
//  Created by Per Pert on 3/28/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        Cart.shared.uiDelegate = self
        Cart.shared.uiDelegat1 = self
        cartTableView.rowHeight = UITableView.automaticDimension
        cartTableView.estimatedRowHeight = UITableView.automaticDimension
        cartTableView.tableFooterView = UIView()  // приховати полоски на табл
    }
    
    @IBAction func toOrderButton(_ sender: UIButton) {
    }
}


extension CartVC: CartUIDelegateProtocol {
    
    func cartOrderIsChnaged() {
        print(#function)
        var totalPrice = 0
        Cart.shared.cartArrayItem.forEach { (item) in
            let priceOneProduct = item.price * 27 * item.count
            totalPrice += priceOneProduct
        }
        totalPriceLabel.text = totalPrice.description
        cartTableView.reloadData()
    }
}

extension CartVC: CartUIDelegat {
    func reloadTotalCount() {
        print("delegate")
        totalPriceLabel.text = "0"
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.cartArrayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath) as! CartTVC
        let productInCart = Cart.shared.cartArrayItem[indexPath.row]
        cell.fillIn(productInCart)
        return cell
    }
    
    //delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            Cart.shared.cartArrayItem.remove(at: indexPath.row)
            cartTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

