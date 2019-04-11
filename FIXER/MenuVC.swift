//
//  MenuVC.swift
//  FIXER
//
//  Created by Per Pert on 3/14/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    let net = Network()
    var menu: MenuStruct? = nil
    var category = [Page]()
    var selectRow: Int?

    @IBOutlet weak var tableViewMenu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        net.getToken {
            self.net.loadMenu()
        }
        
        
        
        
        let count = menu?.response.pages.count ?? 0
        tableViewMenu.dataSource = self
        tableViewMenu.delegate = self
        for i in 0..<count {
            if menu?.response.pages[i].parent == 1273 {
                category.append((menu?.response.pages[i])!)
                //                print(menu?.response.pages[i])
                //                print(category.count)
            }
        }
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath)
        let titleMenuRu = category[indexPath.row].title.ua
        cell.textLabel?.text = titleMenuRu
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = category[indexPath.row].id
        self.selectRow = selectRow
        performSegue(withIdentifier: "showTwoMenu", sender: menu)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTwoMenu" {
            if let menuNext = segue.destination as? MenuNextLevel {
                if let senderMenu = sender as? MenuStruct {
                    menuNext.menu = senderMenu
                    menuNext.selectedCategories = selectRow!
                    
                }
            }
        }
    }
}




