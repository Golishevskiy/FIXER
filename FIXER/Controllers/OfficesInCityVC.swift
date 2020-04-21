//
//  OfficesInCityVC.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 14.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

class OfficesInCityVC: UIViewController {

    var selectedCity: String?
    
    var novaPoshtaQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let operation = LoadOfficeNovaPoshta(city: selectedCity!) { (result) in
            for i in result {
                print(i.descriptionRu)
            }
        }
    }
}
