//
//  MenuNextLevelCell.swift
//  FIXER
//
//  Created by Per Pert on 8/29/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation
import UIKit

class MenuNextLevelCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func setupCell(name: String) {
        nameLabel.text = name
        //radius
        viewCell.layer.cornerRadius = 8
        viewCell.layer.shadowColor = UIColor.black.cgColor
        //shadow
        viewCell.layer.shadowOpacity = 0.2
        viewCell.layer.shadowOffset = .zero
        viewCell.layer.shadowRadius = 3
        //border
        viewCell.layer.borderWidth = 0.1
        viewCell.layer.borderColor = UIColor.darkGray.cgColor
        selectionStyle = .none
    }
}
