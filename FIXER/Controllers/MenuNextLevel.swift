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
        self.title = "Бренд"
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
        let cell = tableViewMenu.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MenuNextLevelCell
        let titleCell = category[indexPath.row].title.ua
        cell.setupCell(name: titleCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentID = category[indexPath.item].id
        performSegue(withIdentifier: "showBoard", sender: category)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewMenu.frame.width / 4.5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBoard" {
            if let board = segue.destination as? BoardProducts {
                    board.CategoryId = parentID
            }
        }
    }
}
