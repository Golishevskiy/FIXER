//
//  SearchOfficeVC.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 23.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

class SearchOfficeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var officesTextField: UITextField!
    @IBOutlet weak var officesTableView: UITableView!
    
    var cityRef: String?
    var delegate: PassDataOffice?
    var result: [Datum] = []
    
    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let operation = LoadOfficeNovaPoshta(city: cityRef!) { (result) in
            DispatchQueue.main.async {
                self.result = result
                self.officesTableView.reloadData()
            }
            
            for i in result {
                print(i.descriptionRu)
            }
        }
        
        queue.addOperation(operation)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = officesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = result[indexPath.row].shortAddress
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.passDataOffice(nameOffice: result[indexPath.row].shortAddress!)
        dismiss(animated: true)
    }
    
    
}
