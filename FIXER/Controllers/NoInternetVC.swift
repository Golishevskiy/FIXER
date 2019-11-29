//
//  NoInternetVC.swift
//  FIXER
//
//  Created by Per Pert on 20.11.2019.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Alamofire

class NoInternetVC: UIViewController {
    
    @IBAction func refreshInternet(_ sender: UIButton) {
        print("refreshInternet()")
        if InternetConnection.isConnectedToInternet {
            performSegue(withIdentifier: "loadMenuSegue", sender: nil)
        } else {
            UIAlertController.alert(title: "No connectio", msg: "pls refresh internet connection", target: self)
        }
    }
}

