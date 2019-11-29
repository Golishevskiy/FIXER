//
//  BoardProducts.swift
//  FIXER
//
//  Created by Per Pert on 24.09.2019.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class BoardProducts: UIViewController {
    
    @IBOutlet weak var boardTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var CategoryId: Int?
    var filteredProducts: [ProductViewModel] = []
    
    private var resultSearch: [ProductViewModel] = []
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Товары"
        
        self.boardTableView.delegate = self
        self.boardTableView.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        boardTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !InternetConnection.isConnectedToInternet {
            UIView.setAnimationsEnabled(false)
            performSegue(withIdentifier: "noConnectSegue", sender: nil)
        } else {
            UIView.setAnimationsEnabled(true)
            if filteredProducts.count != 0 { return }
            activityIndicator.startAnimating()
            Network.shared.getToken { [weak self] in
                guard let id = self?.CategoryId else { return }
                Network.shared.loadProduct(idCategory: String(id)) { [weak self] (items) in
                    //                let objSinglton = items
                    
                    for product in items.response.products {
                        let viewModel = ProductViewModel(product: product)
                        self?.filteredProducts.append(viewModel)
                    }
                    
                    DispatchQueue.main.async{ [weak self] in
                        self?.activityIndicator.stopAnimating()
                        self?.activityIndicator.hidesWhenStopped = true
                        self?.boardTableView.reloadData()
                    }
                }
            }
        }
    }
}


extension BoardProducts: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return resultSearch.count
        }
        return filteredProducts.isEmpty ? 0 : filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! BoardCell
        
        var product: ProductViewModel
        
        if isFiltering {
            product = resultSearch[indexPath.row]
        } else {
            product = filteredProducts[indexPath.row]
        }
        
        //        let product = filteredProducts[indexPath.item]
        cell.fill(product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: filteredProducts[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let detail = segue.destination as? DetailProductVC {
                if let filteredProducts = sender as? ProductViewModel {
                    detail.item = filteredProducts
                    
                    guard let indexPath = boardTableView.indexPathForSelectedRow else { return }
                    
                    var product: ProductViewModel
                    
                    if isFiltering {
                        product = resultSearch[indexPath.row]
                    } else {
                        product = self.filteredProducts[indexPath.row]
                    }
                    
                    let detail = segue.destination as! DetailProductVC
                    detail.item = product
                }
            }
        }
    }
}

extension BoardProducts: UISearchBarDelegate {
    
}

extension BoardProducts: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(textDidChange: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(textDidChange searchText: String) {
        resultSearch = filteredProducts
        
        if searchText.isEmpty == false {
            resultSearch = filteredProducts.filter({ $0.product.description.ru.lowercased().contains(searchText.lowercased()) })
            print("resultSearch")
        }
        boardTableView.reloadData()
    }
}

