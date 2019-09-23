//
//  BoardProduct.swift
//  FIXER
//
//  Created by Per Pert on 3/15/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class BoardProduct: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var productFiltered: [Page] = []
    var CategoryId: Int?
    var filteredProducts: [ProductViewModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Товари"
        
        activity.startAnimating()

        Network.shared.getToken { [weak self] in
            guard let id = self?.CategoryId else { return }
            Network.shared.loadProduct(idCategory: String(id)) { [weak self] (items) in
                let objSinglton = items
                
                for product in objSinglton.response.products {
                    let viewModel = ProductViewModel(product: product)
                    self?.filteredProducts.append(viewModel)
                }
                
                DispatchQueue.main.async{ [weak self] in
                    self?.activity.stopAnimating()
                    self?.activity.hidesWhenStopped = true
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 250)
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
    //for SwiftUI
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let product = filteredProducts[indexPath.row]
//        let DetailScren = DetailView(item: product)
//
//        if #available(iOS 13.0, *) {
//            let host = UIHostingController(rootView: DetailScren)
//            navigationController?.pushViewController(host, animated: true)
//        } else {
//            print("not work")
//        }
//    }
}



