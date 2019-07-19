//
//  MenuNextLevel.swift
//  FIXER
//
//  Created by Per Pert on 3/15/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class MenuNextLevel: UIViewController {
    
    @IBOutlet weak var tableViewMenu: UITableView!
    
    var menu: [Page] = []
    var selectedCategories: Int?
    var category = [Page]()
    var parentID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = menu.count
        for i in 0..<count {
            if menu[i].parent == selectedCategories {
                category.append((menu[i]))
                tableViewMenu.reloadData()
            }
        }
    }
}

extension MenuNextLevel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMenu.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let titleCell = category[indexPath.row].title.ua
        cell.textLabel?.text = titleCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentID = category[indexPath.item].id
        performSegue(withIdentifier: "showBoard", sender: category)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBoard" {
            if let board = segue.destination as? BoardProduct {
                if let senderCategory = sender as? [Page] {
                    board.productFiltered = senderCategory
                    board.CategoryId = parentID
                }
            }
        }
    }
}
