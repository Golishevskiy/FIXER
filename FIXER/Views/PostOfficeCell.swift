//
//  PostOfficeCell.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 25.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

class PostOfficeCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func fillIn(number: String, address: String) {
        numberLabel.text = "№\(number)"
        addressLabel.text = address
    }
}
