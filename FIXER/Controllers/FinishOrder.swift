//
//  FinishOrder.swift
//  FIXER
//
//  Created by Per Pert on 5/4/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

enum Delivery : String {
    case InOffice = "Самовывоз"
    case NovaPoshta = "Новая почта"
    case Courier = "Kypьep"
}



class FinishOrder: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    private var deliveryOptions = ["Самовивіз", "Доставка НП", "Кур'єром (Київ)"]
    private var deliveryMethod = ""
    private var deliveryOptions = [
        Delivery.InOffice.rawValue,
        Delivery.NovaPoshta.rawValue,
        Delivery.Courier.rawValue
    ]
    
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
        deliveryMethod = Delivery.InOffice.rawValue
        cityDelivery.isHidden = true
        postOfficeDeliveryr.isHidden = true
        shippingAddress.isHidden = true
        fixcenterAddress.isHidden = false
        
        //for button finish order
        finishOrderButton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0, alpha: 1)
        finishOrderButton.setTitle("Оформить", for: .normal)
        finishOrderButton.layer.cornerRadius = finishOrderButton.frame.height / 2
        finishOrderButton.setTitleColor(.white, for: .normal)
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkAllData() -> Bool {
        if  checkLastname() && checkFirstName() && checkPhone() && checkShipping() {
            return true
        } else {
            return false
        }
    }
    
    private func checkFirstName() -> Bool {
        if firstNameShopper.text! != "" {
            return true
        } else {
            print(#function)
            UIAlertController.alert(title: "Ошибка", msg: "Пожалуйста, напишите имя", target: self)
            return false
        }
    }
    
    private func checkLastname() -> Bool {
        if secondNameShopper.text! != "" {
            return true
        } else {
            print(#function)
            UIAlertController.alert(title: "Ошибка", msg: "Пожалуйста, напишите фамилию", target: self)
            return false
        }
    }
    
    private func checkPhone() -> Bool {
        if phoneShopper.text! != "" {
            return true
        } else {
            UIAlertController.alert(title: "Ошибка", msg: "Пожалуйста, напишите телефон", target: self)
            return false
        }
    }
    
    private func checkCourier(str: String) -> Bool {
        if str != "" {
            return true
        } else {
            UIAlertController.alert(title: "Ошибка", msg: "Пожалуйста, напишите адрес доставки", target: self)
            return false
        }
    }
    
    private func checkPost(city: String, office: String) -> Bool {
        if city != "" && office != "" {
            return true
        } else if city == "" {
            UIAlertController.alert(title: "Ошибка", msg: "Пожалуйста, напишите город", target: self)
            return false
        } else {
            UIAlertController.alert(title: "Ошибка", msg: "Пожалуйста, напишите номер отделения", target: self)
            return false
        }
    }
    
    private func checkShipping() -> Bool {
        
        if deliveryMethod == Delivery.Courier.rawValue {
            return checkCourier(str: shippingAddress.text!)
        } else if deliveryMethod == Delivery.NovaPoshta.rawValue {
            return checkPost(city: cityDelivery.text!, office: postOfficeDeliveryr.text!)
        } else if deliveryMethod == Delivery.InOffice.rawValue {
            return true
        } else {
            return false
        }
    }
    
    //sender order to telegram
    @IBAction func finishOrderButton(_ sender: UIButton) {
        if InternetConnection.isConnectedToInternet && checkAllData() {
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
        } else {
            UIAlertController.alert(title: "Не получиться", msg: "Пожалуйста, подключитесь к интернету", target: self)
        }
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
        
        if deliveryMethod == Delivery.NovaPoshta.rawValue {
            cityDelivery.isHidden = false
            postOfficeDeliveryr.isHidden = false
            shippingAddress.isHidden = true
            fixcenterAddress.isHidden = true
        }
        if deliveryMethod == Delivery.Courier.rawValue {
            shippingAddress.isHidden = false
            postOfficeDeliveryr.isHidden = true
            cityDelivery.isHidden = true
            fixcenterAddress.isHidden = true
        }
        if deliveryMethod == Delivery.InOffice.rawValue {
            cityDelivery.isHidden = true
            postOfficeDeliveryr.isHidden = true
            shippingAddress.isHidden = true
            fixcenterAddress.isHidden = false
        }
    }
    
    //api manager telegram
    private func orderInformationForTelegram() -> String? {
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
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
}
