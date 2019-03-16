//
//  BoardProduct.swift
//  FIXER
//
//  Created by Per Pert on 3/15/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class BoardProduct: UICollectionViewController {
    
    var productFiltered: [Page] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BoardProduct CLASS")
        print(productFiltered.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.nameProductCell.text = productFiltered[indexPath.item].title.ua
        return cell
    }
    
}

