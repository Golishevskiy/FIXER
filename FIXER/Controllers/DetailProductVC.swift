//
//  DetailProductVC.swift
//  FIXER
//
//  Created by Per Pert on 3/22/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Foundation


class DetailProductVC: UIViewController {
    var item: ProductViewModel?
    private var images: [UIImage] = []
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    //    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var bayButton: UIButton!

    
    var indexForPageControll = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionViewSlider.delegate = self
        collectionViewSlider.dataSource = self
        
        
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .gray
        pageControl.numberOfPages = item?.product.images.count ?? 1
        self.title = "Детальніше"
        bayButton.backgroundColor = .orange
        bayButton.layer.cornerRadius = 7
        bayButton.layer.shadowRadius = 7
        if #available(iOS 13.0, *) {
            bayButton.layer.shadowColor = CGColor(srgbRed: 0.4, green: 0.8, blue: 0, alpha: 0)
        } else {
            // Fallback on earlier versions
        }
        CheckProductInCartAfterReloadMenu(productInCart: Cart.shared.cartArrayItem, slectedProduct: item!)
//        itemImage.image = item?.image ?? UIImage(named: "noPhoto")
        nameLabel.text = item?.product.title.ru
        guard let price = item?.product.price else { return }
        priceLabel.text = String(Int(price) * 27)
        guard let descr = item?.product.description.ru else { return }
        textViewDescription.attributedText = try? NSAttributedString(htmlString: descr)
        textViewDescription.isEditable = false
    }
    
    @IBAction func addToCart(_ bayButton: UIButton) {
        guard let itemProd = item else { return }
        Cart.shared.addItemToCart(item: itemProd)
        bayButton.setTitle("в корзине", for: .normal)
        let textColorButton = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        bayButton.setTitleColor(textColorButton, for: .normal)
        bayButton.isEnabled = false
        item?.cartStatus = true
    }
    
    func CheckProductInCartAfterReloadMenu(productInCart: [ProductInCart], slectedProduct: ProductViewModel) {
        for i in productInCart {
            if String(i.article) == item?.product.article {
                bayButton.isEnabled = false
                bayButton.setTitle("в корзине", for: .normal)
                let textColorButton = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                bayButton.setTitleColor(textColorButton, for: .normal)
            }
        }
    }    
    }

extension NSAttributedString {
    convenience init(htmlString html: String) throws {
        try self.init(data: Data(html.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
    }
}

extension DetailProductVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.product.images.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageSlider
//        cell.backgroundColor = .gray
        cell.setupCell(image: (item?.product.images[indexPath.row])!)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        indexForPageControll = Int(scrollView.contentOffset.x / collectionViewSlider.frame.size.width)
        pageControl.currentPage = indexForPageControll
    }
}

extension DetailProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        return CGSize(width: width, height: width/2)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

