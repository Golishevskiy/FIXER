//
//  MenuVC.swift
//  FIXER
//
//  Created by Per Pert on 3/14/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Alamofire

class MenuVC: UIViewController {
    
    // property
    private var category = [Page]()
    private var allCategoryMenu = [Page]()
    private var selectRow: Int?
    private var x = Menu()
    private var menuOneLine = [1186,
                               1052,
                               1053,
                               1055,
                               1207]
    // outlet
    @IBOutlet weak var tableViewMenu: UITableView!
    @IBOutlet weak var activityLoadMenu: UIActivityIndicatorView!
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Каталог"
        self.navigationController?.navigationBar.tintColor = .orange
                
        tableViewMenu.dataSource = self
        tableViewMenu.delegate = self
        tableViewMenu.tableFooterView = UIView()
        activityLoadMenu.startAnimating()
        
        print(CFGetRetainCount(tableViewMenu as CFTypeRef))
        
        if InternetConnection.isConnectedToInternet {
            Network.shared.getToken {
                Network.shared.loadMenu(completion: { (menu) in
                    self.allCategoryMenu = menu.response.pages
                    let count = self.allCategoryMenu.count
                    for i in 0..<count {
                        if self.allCategoryMenu[i].parent == 1273 {
                            self.category.append((self.allCategoryMenu[i]))
                        }
                    }
                    self.x.sortedMenu(response: self.allCategoryMenu)
                    
                    DispatchQueue.main.async { [weak self] in
                        self!.tableViewMenu.reloadData()
                        self?.activityLoadMenu.stopAnimating()
                    }
                })
            }
        } else {
            UIAlertController.alert(title: "Упс",
                                    msg: "Відсутнє підключення до інтернету",
                                    target: self)
            activityLoadMenu.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(CFGetRetainCount(tableViewMenu as CFTypeRef))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("disappear")
        print(CFGetRetainCount(tableViewMenu as CFTypeRef))
    }
    
    deinit {
        print("category = \(category)")
        print("------------------------------")
        print("view = \(view) tableView = \(tableViewMenu) activityLoadMenu = \(activityLoadMenu)")
    }
}

// extension
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as! MenuCell
        let titleMenuRu = category[indexPath.row].title.ru
        cell.setupCell(name: titleMenuRu)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = category[indexPath.row].id
        self.selectRow = selectRow
        
        if menuOneLine.contains(selectRow) {
            performSegue(withIdentifier: "toBoard", sender: selectRow)
            return
        }
        performSegue(withIdentifier: "showTwoMenu", sender: allCategoryMenu)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width / 4.5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTwoMenu" {
            if let menuNext = segue.destination as? MenuNextLevel {
                if let senderMenu = sender as? [Page] {
                    menuNext.menu = senderMenu
                    menuNext.selectedCategories = selectRow!
                }
            }
        }
        
        if segue.identifier == "toBoard" {
            if let board = segue.destination as? BoardProducts {
                board.CategoryId = self.selectRow
                print(selectRow as Any)
            }
        }
    }
}




