//
//  BoardProduct.swift
//  FIXER
//
//  Created by Per Pert on 3/15/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class BoardProduct: UICollectionViewController {
    
    @IBOutlet weak var activiti: UIActivityIndicatorView!
    
    var productFiltered: [Page] = []
    var CategoryId: Int?
    var filteredProducts: [ProductViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activiti.startAnimating()
        
        Network.shared.getToken { [weak self] in
            guard let id = self?.CategoryId else { return }
            Network.shared.loadProduct(idCategory: String(id)) { [weak self] in
                guard let objSinglton = Network.shared.items else { return }
                
                for product in objSinglton.response.products {
                    let viewModel = ProductViewModel(product: product)
                    self?.filteredProducts.append(viewModel)
                }
                
                DispatchQueue.main.async{ [weak self] in
                    self?.activiti.stopAnimating()
                    self?.activiti.hidesWhenStopped = true
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = filteredProducts[indexPath.item]
        cell.fill(product)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: filteredProducts[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let detail = segue.destination as? DetailProductVC {
                if let filteredProducts = sender as? ProductViewModel {
                    detail.item = filteredProducts
                }
            }
        }
    }
}

