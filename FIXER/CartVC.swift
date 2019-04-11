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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartTableView.reloadData()
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.cartArrayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTVC
        let title = Cart.shared.cartArrayItem[indexPath.row].name
        let price = Cart.shared.cartArrayItem[indexPath.row].price
        let count = Cart.shared.cartArrayItem[indexPath.row].count
        cell.nameLabel.text = title
        cell.priceLabel.text = String(price)
        cell.countLabel.text = String(count)
        cell.cartImageView.image = Cart.shared.cartArrayItem[indexPath.row].image
        cell.count = Cart.shared.cartArrayItem[indexPath.row]
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
        return 100.0
        //        return .automaticDimension
    }
}
