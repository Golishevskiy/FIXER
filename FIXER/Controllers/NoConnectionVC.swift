//
//  NoConnectionVC.swift
//  FIXER
//
//  Created by Per Pert on 22.11.2019.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Alamofire

class NoConnectionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        refreshInternet()
    }
    
    func refreshInternet() {
        if InternetConnection.isConnectedToInternet {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
