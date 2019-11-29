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
    @IBOutlet weak var bayButton: UIButton!
    
    
    override func viewDidLoad() {
        self.title = "Корзина"
        cartOrderIsChnaged()
        Cart.shared.uiDelegate = self
        Cart.shared.uiDelegat1 = self
        cartTableView.rowHeight = UITableView.automaticDimension
        cartTableView.estimatedRowHeight = UITableView.automaticDimension
        cartTableView.tableFooterView = UIView()  // приховати полоски на табл
//        bayButton.layer.cornerRadius = CGFloat(bayButton.frame.height / 4)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !checkCountInCart() {
            UIAlertController.alert(title: "Корзина пуста", msg: "Пожалуйста, положите товар в корзину", target: self)
        }
    }
    
    @IBAction func toOrderButton(_ sender: UIButton) {
        checkCartForUserNotification()
    }
    
    
    func checkCountInCart() -> Bool {
        if Cart.shared.cartArrayItem.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    func checkCartForUserNotification() {
        if checkCountInCart() {
            performSegue(withIdentifier: "toOrderSegue", sender: nil)
        } else {
            UIAlertController.alert(title: "Корзина пуста", msg: "Пожалуйста, положите товар в корзину", target: self)
        }
    }
}

extension CartVC: CartUIDelegateProtocol {
    
    func cartOrderIsChnaged() {
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
        totalPriceLabel.text = "0"
        self.cartTableView.reloadData()
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.cartArrayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            cartOrderIsChnaged()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIAlertController {
    
    class func alert(title: String, msg: String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default) {
            (result: UIAlertAction) -> Void in
        })
        target.present(alert, animated: true, completion: nil)
    }
}

