//
//  FinishOrder.swift
//  FIXER
//
//  Created by Per Pert on 5/4/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

class FinishOrder: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var deliveryOptions = ["Самовивіз", "Доставка НП", "Кур'єром (Київ)"]
    var deliveryMethod = ""
    
    @IBOutlet weak var finishOrderButton: UIButton!
    @IBOutlet weak var fixcenterAddress: UILabel!
    @IBOutlet weak var postOfficeDeliveryr: UITextField!
    @IBOutlet weak var shippingAddress: UITextField!
    @IBOutlet weak var cityDelivery: UITextField!
    @IBOutlet weak var phoneShopper: UITextField!
    @IBOutlet weak var firstNameShopper: UITextField!
    @IBOutlet weak var nameShopper: UITextField!
    @IBOutlet weak var myPicker: UIPickerView!
    
    override func viewDidLoad() {
        cityDelivery.isHidden = true
        postOfficeDeliveryr.isHidden = true
        shippingAddress.isHidden = true
        fixcenterAddress.isHidden = false
        
        //for button finish order
        finishOrderButton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0, alpha: 1)
        finishOrderButton.setTitle("Оформити", for: .normal)
        finishOrderButton.layer.cornerRadius = finishOrderButton.frame.height / 2
        finishOrderButton.setTitleColor(.white, for: .normal)
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishOrderButton(_ sender: UIButton) {
        let apiToken = "861029744:AAF83m9tfZ1k8HnXteFsrJQYawEQdkMTAYo"
        let chatId = "@fixcenterOrder"
        var strUrl = "https://api.telegram.org/bot%@/sendMessage?chat_id=%@&text=%@"
        
        strUrl = String(format: strUrl, apiToken, chatId, orderInformationForTelegrams()!)
        print(strUrl)
        let url = URL(string: strUrl)
        guard let newUrl = url else {return}
        let downloadTask = URLSession.shared.dataTask(with: newUrl) { (data : Data?, response : URLResponse?, error : Error?) in
            print(data!)
            print(response!)
            print(error?.localizedDescription)
        }
        downloadTask.resume()
        
        Cart.shared.clearCart()
        if Cart.shared.cartArrayItem.isEmpty {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return deliveryOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return deliveryOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        deliveryMethod = deliveryOptions[row]
        
        if deliveryMethod == "Доставка НП" {
            cityDelivery.isHidden = false
            postOfficeDeliveryr.isHidden = false
            shippingAddress.isHidden = true
            fixcenterAddress.isHidden = true
        }
        if deliveryMethod == "Кур'єром (Київ)" {
            shippingAddress.isHidden = false
            postOfficeDeliveryr.isHidden = true
            cityDelivery.isHidden = true
            fixcenterAddress.isHidden = true
        }
        if deliveryMethod == "Самовивіз" {
            cityDelivery.isHidden = true
            postOfficeDeliveryr.isHidden = true
            shippingAddress.isHidden = true
            fixcenterAddress.isHidden = false
        }
    }
    
    func orderInformationForTelegrams() -> String? {
        var textOrder = "#ЗАКАЗ#"
        for i in Cart.shared.cartArrayItem {
            textOrder = "\(textOrder)\n+\(i.name) x \(i.count.description)шт\nАртикул - \(i.article)\nЦіна - \(i.price)\n-----------------------------------------------"
        }
        
        textOrder = "\(textOrder)\n*ПОКУПАТЕЛЬ:*\n\(firstNameShopper.text!) \(nameShopper.text!) \(phoneShopper.text!)\n*ДОСТАВКА:*\n\(deliveryMethod)\n\(shippingAddress.text ?? "")\(cityDelivery.text ?? "")\n\(postOfficeDeliveryr.text ?? "")"
        let resultTextOrder = textOrder.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        return resultTextOrder
    }
}
