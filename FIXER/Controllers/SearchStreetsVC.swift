//
//  SearchStreetsVC.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 19.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit
import AudioToolbox

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
        searchStreetTextField.becomeFirstResponder()
        searchStreetTextField.addTarget(self, action: #selector(loadStreets), for: .editingChanged)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    @objc func loadStreets(textField: UITextField) {
        let alphbet = "qwertyuiopasdfghjklzxcvbnm"
        guard let char = textField.text?.last?.lowercased() else { return }
        if alphbet.contains(char) {
            AudioServicesPlaySystemSound(1521)
            UIAlertController.alert(title: "Ошибка", msg: "Попробуйте писать назваие улицы на укр. или рус. языке", target: self)
            searchStreetTextField.text?.removeLast()
        }
        guard let nameStreet = textField.text else { return }
        let operation = LoadStreetsKyivOperation(searchStreet: nameStreet) { (res) in
            self.result = res
            DispatchQueue.main.async {
                self.stretsTableView.reloadData()
            }
        }
        
        if nameStreet.count >= 2 {
            self.queue.addOperation(operation)
        }
        
        if nameStreet.count < 2 {
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
        if result[indexPath.row].descriptionRU == "" {
            cell.textLabel?.text = result[indexPath.row].present
            return cell
        } else {
            cell.textLabel?.text = typeStreet + " " + result[indexPath.row].descriptionRU
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectRow = indexPath.row
        
        let item = result[indexPath.row]
        let typeStreet = checkTypeStreet(street: item)
        if result[indexPath.row].descriptionRU == "" {
            let nameStreet = result[indexPath.row].present
            delegate?.passData(name: nameStreet)
            dismiss(animated: true)
        } else {
            let nameStreet = typeStreet + " " + result[indexPath.row].descriptionRU
            
            //        let street = result[indexPath.row].present
            delegate?.passData(name: nameStreet)
            dismiss(animated: true)
        }
    }
    
    func checkTypeStreet(street: Street) -> String {
        switch street.streetType {
        case "вул.": return "ул."
        case "пл.": return "пл."
        case "бул.": return "бул."
        case "пров.": return "проул."
        case "просп.": return "просп."
        case "шосе": return "шоссе"
        default:
            return ""
        }
    }
}
