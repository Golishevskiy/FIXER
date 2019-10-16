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
    @IBOutlet weak var secondNameShopper: UITextField!
    @IBOutlet weak var myPicker: UIPickerView!
    
    override func viewDidLoad() {
        deliveryMethod = "Самовивіз"
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
    
    func checkAllData() -> Bool {
        if  checkLastname() && checkFirstName() && checkPhone() && checkShipping() {
            return true
        } else {
            return false
        }
    }
    
    func checkFirstName() -> Bool {
        if firstNameShopper.text! != "" {
            return true
        } else {
            print(#function)
            UIAlertController.alert(title: "Помилка", msg: "Будь ласка, введіть ім'я", target: self)
            return false
        }
    }
    
    func checkLastname() -> Bool {
        if secondNameShopper.text! != "" {
            return true
        } else {
            print(#function)
            UIAlertController.alert(title: "Помилка", msg: "Будь ласка, введіть прізвище", target: self)
            return false
        }
    }
    
    func checkPhone() -> Bool {
        if phoneShopper.text! != "" {
            return true
        } else {
            UIAlertController.alert(title: "Помилка", msg: "Будь ласка, введіть телефон", target: self)
            return false
        }
    }
    
    func checkCourier(str: String) -> Bool {
        if str != "" {
            return true
        } else {
            UIAlertController.alert(title: "Помилка", msg: "Будь ласка, введіть адресу доставки", target: self)
            return false
        }
    }
    
    func checkPost(city: String, office: String) -> Bool {
        if city != "" && office != "" {
            return true
        } else if city == "" {
            UIAlertController.alert(title: "Помилка", msg: "Будь ласка, введіть місто отримувача", target: self)
            return false
        } else {
            UIAlertController.alert(title: "Помилка", msg: "Будь ласка, введіть номер відділення", target: self)
            return false
        }
    }
    
    func checkShipping() -> Bool {
        
        if deliveryMethod == "Кур'єром (Київ)" {
            return checkCourier(str: shippingAddress.text!)
        } else if deliveryMethod == "Доставка НП" {
            return checkPost(city: cityDelivery.text!, office: postOfficeDeliveryr.text!)
        } else if deliveryMethod == "Самовивіз" {
            print("Самовивіз")
            return true
        } else {
            return false
        }
    }
    
    //sender order to telegram
    @IBAction func finishOrderButton(_ sender: UIButton) {
        if checkAllData() {
            let apiToken = "861029744:AAF83m9tfZ1k8HnXteFsrJQYawEQdkMTAYo"
            let chatId = "@fixcenterOrder"
            var strUrl = "https://api.telegram.org/bot%@/sendMessage?chat_id=%@&text=%@"
            
            strUrl = String(format: strUrl, apiToken, chatId, orderInformationForTelegram()!)
            let url = URL(string: strUrl)
            guard let newUrl = url else {return}
            let downloadTask = URLSession.shared.dataTask(with: newUrl) { (data : Data?, response : URLResponse?, error : Error?) in
            }
            downloadTask.resume()
            
            Cart.shared.clearCart()
            if Cart.shared.cartArrayItem.isEmpty {
                self.dismiss(animated: true, completion: nil)
            }
        }
        print(checkAllData())
    }
    
    //setup Picker
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
    
    //api manager telegram
    func orderInformationForTelegram() -> String? {
        var textOrder = "#ЗАКАЗ#"
        for i in Cart.shared.cartArrayItem {
            textOrder = "\(textOrder)\n+\(i.name) x \(i.count.description)шт\nАртикул - \(i.article)\nЦіна - \(i.price)\n-----------------------------------------------"
        }
        
        textOrder = "\(textOrder)\n*ПОКУПАТЕЛЬ:*\n\(firstNameShopper.text!) \(secondNameShopper.text!) \(phoneShopper.text!)\n*ДОСТАВКА:*\n\(deliveryMethod)\n\(shippingAddress.text ?? "")\(cityDelivery.text ?? "")\n\(postOfficeDeliveryr.text ?? "")"
        let resultTextOrder = textOrder.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        return resultTextOrder
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
