//
//  StartScreenVC.swift
//  FIXER
//
//  Created by Per Pert on 19.11.2019.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Alamofire

class StartScreenVC: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        internetConnection()
    }
    
    public func internetConnection() {
        if InternetConnection.isConnectedToInternet {
            performSegue(withIdentifier: "loadMenuSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "noInternetSegue", sender: nil)
        }
    }
}
