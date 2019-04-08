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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)  {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
