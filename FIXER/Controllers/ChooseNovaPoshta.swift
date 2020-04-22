//
//  ChooseNovaPoshta.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 14.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

protocol PassData: class {
    func passdataBack(id: String, name: String)
}


class ChooseNovaPoshta: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
   
    private var resultData: [ResultCity] = []
    var novaPoshtaQueue = OperationQueue()
    weak var delegate: PassData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.addTarget(self, action: #selector(loadSearchResult), for: .editingChanged)
        
        
    }
    
    @objc func loadSearchResult(textField: UITextField) {        
        if textField.text!.count >= 2 {
            NovaPoshta.loadSearchCity(search: textField.text) { (response) in
                guard let result = response.data else { return }
                self.resultData = result
                print(result.count)
                DispatchQueue.main.async {
                    self.resultTableView.reloadData()
                }
            }
        }
        
        if textField.text!.count < 2 {
            self.resultData = []
            self.resultTableView.reloadData()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = resultData[indexPath.row].description
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelected")
            guard let cityRef = resultData[indexPath.row].ref else { return }
        guard let cityName = resultData[indexPath.row].description else { return }
        delegate?.passdataBack(id: cityRef, name: cityName)
        dismiss(animated: true)
        
        
//        let city = resultData[indexPath.row].ref

//        let operation = LoadOfficeNovaPoshta(city: city!) { (result) in
//            for i in result {
//                print("№\(i.number!) (\(i.shortAddress!))")
//            }
//        }
        
//        novaPoshtaQueue.addOperation(operation)
    }
}
