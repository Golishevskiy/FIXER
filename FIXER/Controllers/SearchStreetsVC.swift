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
        stretsTableView.tableFooterView = UIView()
        
        searchStreetTextField.addTarget(self, action: #selector(loadStreets), for: .editingChanged)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    @objc func loadStreets(textField: UITextField) {
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
        let item = result[indexPath.row]
        let typeStreet = checkTypeStreet(street: item)
        cell.textLabel?.text = typeStreet + " " + result[indexPath.row].descriptionRU
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectRow = indexPath.row
        
        let item = result[indexPath.row]
        let typeStreet = checkTypeStreet(street: item)
        let nameStreet = typeStreet + " " + result[indexPath.row].descriptionRU
        
//        let street = result[indexPath.row].present
        delegate?.passData(name: nameStreet)
        dismiss(animated: true)
    }
    
    func checkTypeStreet(street: Street) -> String {
        switch street.streetType {
               case "вул.": return "ул."
               case "пл.": return "пл."
               case "бул.": return "бул."
               case "пров.": return "проул."
               default:
                   return ""
               }
    }
}
