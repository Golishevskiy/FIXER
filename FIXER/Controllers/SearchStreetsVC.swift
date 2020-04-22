//
//  SearchStreetsVC.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 19.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

class SearchStreetsVC: UIViewController {
    
    @IBOutlet weak var searchStreetTextField: UITextField!
    @IBOutlet weak var stretsTableView: UITableView!
    
    private var selectRow: Int?
    var queue = OperationQueue()
    weak var delegate: PassDataStreet?
    var result: [Street] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchStreetTextField.addTarget(self, action: #selector(loadStreets), for: .editingChanged)
    }
    
    @objc func loadStreets(textField: UITextField) {
        print(textField.text)
        
        let operation = LoadStreetsKyivOperation(searchStreet: textField.text!) { (res) in
            self.result = res
            DispatchQueue.main.async {
                self.stretsTableView.reloadData()
            }
        }
        
        
        if textField.text!.count >= 2 {
            self.queue.addOperation(operation)
        }
        
        if textField.text!.count < 2 {
            self.result = []
            self.stretsTableView.reloadData()
        }
    }
}

extension SearchStreetsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stretsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = result[indexPath.row].present
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectRow == indexPath.row {
            return 200
        }
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectRow = indexPath.row
        
        let street = result[indexPath.row].present
        delegate?.passData(name: street)
        dismiss(animated: true)
    }
}
