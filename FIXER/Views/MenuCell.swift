//
//  MenuCell.swift
//  FIXER
//
//  Created by Per Pert on 8/27/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nameMenuLabel: UILabel!
    
    func setupCell(name: String) {
        nameMenuLabel.text = name
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
