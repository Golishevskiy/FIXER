//
//  SearchOfficeVC.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 23.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import UIKit

class SearchOfficeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var officesTableView: UITableView!
    
    private let queue = OperationQueue()
    private var result: [Datum] = []
    var delegate: PassDataOffice?
    var cityRef: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        officesTableView.tableFooterView = UIView()
        if cityRef != nil && cityRef != "" {
            let operation = LoadOfficeNovaPoshta(city: cityRef!) { (result) in
                DispatchQueue.main.async {
                    self.result = result
                    self.officesTableView.reloadData()
                }
            }
            queue.addOperation(operation)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = officesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostOfficeCell
        let item = result[indexPath.row]
        cell.fillIn(number: item.number!, address: item.shortAddressRu!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.passDataOffice(nameOffice: result[indexPath.row].number!)
        dismiss(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
