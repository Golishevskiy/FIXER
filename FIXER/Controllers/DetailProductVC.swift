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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var bayButton: UIButton!
    @IBOutlet weak var cartStatusLabel: UILabel!
    
    var indexForPageControll = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSlider.delegate = self
        collectionViewSlider.dataSource = self
        
        self.pageControl.addTarget(self, action: #selector(self.pageChanged(sender:)), for: UIControl.Event.valueChanged)
        
        
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .gray
        pageControl.numberOfPages = item?.product.images.count ?? 1
        self.title = "О товаре"
        bayButton.backgroundColor = .orange
        bayButton.layer.cornerRadius = 7
        bayButton.layer.shadowRadius = 7
        bayButton.layer.shadowColor = CGColor(_colorLiteralRed: 0.4, green: 0.8, blue: 0, alpha: 0)
        
        bayButton.setTitle("Купить", for: .normal)
        cartStatusLabel.isHidden = true
        PresenceProduct()
        
        CheckProductInCartAfterReloadMenu(productInCart: Cart.shared.cartArrayItem, slectedProduct: item!)
        nameLabel.text = item?.product.title.ru
        guard let price = item?.product.price else { return }
        priceLabel.text = String(Int(price) * 27)
        guard let descr = item?.product.description.ru else { return }
        
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        let attributedString = NSAttributedString(string: descr, attributes: attributes)
        textViewDescription.attributedText = attributedString
        

//        textViewDescription.attributedText = try? NSAttributedString(htmlString: descr)

            
        textViewDescription.isEditable = false
    }
    
    @objc func pageChanged(sender:AnyObject) {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        self.collectionViewSlider.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    @IBAction func addToCart(_ bayButton: UIButton) {
        guard let itemProd = item else { return }
        Cart.shared.addItemToCart(item: itemProd)
        bayButton.isHidden = true
        cartStatusLabel.isHidden = false
        cartStatusLabel.text = "В корзине"
        cartStatusLabel.textColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5)
        cartStatusLabel.font = .boldSystemFont(ofSize: 16)
        item?.cartStatus = true
    }
    
    func CheckProductInCartAfterReloadMenu(productInCart: [ProductInCart], slectedProduct: ProductViewModel) {
        for i in productInCart {
            if String(i.article) == item?.product.article {
                bayButton.isHidden = true
                cartStatusLabel.isHidden = false
                cartStatusLabel.text = "В корзине"
                cartStatusLabel.textColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.5)
                cartStatusLabel.font = .boldSystemFont(ofSize: 16)
            }
        }
    }
    
    func PresenceProduct() {
        if item?.product.presence.id == 2 {
            print(#function)
            bayButton.isHidden = true
            cartStatusLabel.isHidden = false
            cartStatusLabel.text = "Нет в наличии"
            cartStatusLabel.textColor = .gray
            cartStatusLabel.font = .boldSystemFont(ofSize: 16)
        } else {
            return
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
        
        if (item?.product.images.count)! == 0 {
            return 1
        } else {
            return (item?.product.images.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageSlider
        var photo = true
        var image = ""
        if item?.product.images.count == 0 {
            photo = false
        } else {
            image = (item?.product.images[indexPath.row])!
        }
        cell.setupCell(image: image, photoAvailable: photo)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        indexForPageControll = Int(scrollView.contentOffset.x / collectionViewSlider.frame.size.width)
        pageControl.currentPage = indexForPageControll
    }
}

extension DetailProductVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}



