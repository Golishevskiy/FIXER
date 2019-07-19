//
//  ViewController.swift
//  FIXER
//
//  Created by Per Pert on 3/12/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let net = Network()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        net.getToken {
            self.net.loadMenu()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let menuVC = segue.destination as? MenuVC {
                if let senderMenu = sender as? MenuStruct {
                    menuVC.menu = senderMenu
                }
            }
        }
    }
}

