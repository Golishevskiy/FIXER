//
////  BoardProduct.swift
////  FIXER
////
////  Created by Per Pert on 3/15/19.
////  Copyright © 2019 Petro. All rights reserved.
////
//
//import UIKit
//
//class BoardProduct {
//    
//    @IBOutlet weak var activity: UIActivityIndicatorView!
//    
//    var productFiltered: [Page] = []
//    var CategoryId: Int?
//    var filteredProducts: [ProductViewModel] = []
//    
//    
//     func viewDidLoad() {
//        viewDidLoad()
////        self.title = "Товари"
//        
////        self.tableView.delegate = self
////        self.tableView.dataSource = self
//        
//        activity.startAnimating()
////        tableView.separatorStyle = .none
//        //        tableView.estimatedRowHeight = 44
////        tableView.rowHeight = UITableView.automaticDimension
//        
//        Network.shared.getToken { [weak self] in
//            guard let id = self?.CategoryId else { return }
//            Network.shared.loadProduct(idCategory: String(id)) { [weak self] (items) in
//                let objSinglton = items
//                
//                for product in objSinglton.response.products {
//                    let viewModel = ProductViewModel(product: product)
//                    self?.filteredProducts.append(viewModel)
//                }
//                
//                DispatchQueue.main.async{ [weak self] in
//                    self?.activity.stopAnimating()
//                    self?.activity.hidesWhenStopped = true
////                    self?.tableView.reloadData()
//                }
//            }
//        }
//    }
//}
//
//
//
//    
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! BoardCell
////        let product = filteredProducts[indexPath.item]
////        cell.fill(product)
////        return cell
////    }
////
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return filteredProducts.count
////    }
////
////    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        performSegue(withIdentifier: "showDetailSegue", sender: filteredProducts[indexPath.item])
////    }
////
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "showDetailSegue" {
////            if let detail = segue.destination as? DetailProductVC {
////                if let filteredProducts = sender as? ProductViewModel {
////                    detail.item = filteredProducts
////                }
////            }
////        }
////    }
////}
//
//
//
//
//
//
////for SwiftUI
////    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let product = filteredProducts[indexPath.row]
////        let DetailScren = DetailView(item: product)
////
////        if #available(iOS 13.0, *) {
////            let host = UIHostingController(rootView: DetailScren)
////            navigationController?.pushViewController(host, animated: true)
////        } else {
////            print("not work")
////        }
////    }
//
//
//
//
