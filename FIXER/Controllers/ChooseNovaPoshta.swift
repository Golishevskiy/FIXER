//
//  ChooseNovaPoshta.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 14.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

class ChooseNovaPoshta: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    
    private var resultData: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchTextField.addTarget(self, action: #selector(loadSearchResult), for: .editingChanged)
    }
    
    @objc func loadSearchResult(textField: UITextField) {
        print(textField.text?.count)
        
        if textField.text!.count >= 2 {
            NovaPoshta.loadSearchCity(search: textField.text) { (response) in
                let result = response.data[0].addresses
                self.resultData = result
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = resultData[indexPath.row].mainDescription
        return cell
    }
}
