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
    case NovaPoshta = "Новой почтой"
    case Courier = "Курьером по Киеву на завтра"
}

enum PayMethod : String {
    case Cash = "id_15"
    case Privat = "id_16"
    case Novaposhta = "id_13"
}


class FinishOrder: UIViewController {
    
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
    @IBOutlet weak var paySegmentControll: UISegmentedControl!
    @IBOutlet weak var deliverySegmentedControl: UISegmentedControl!
    
    @IBAction func paymentMethod(_ sender: Any) {
        
    }


    
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
        
        cityDelivery.addTarget(self, action: #selector(textFieldTyping), for: .editingChanged)
    }
    
    @objc func textFieldTyping(textField: UITextField)
    {
        print(textField.text?.count)
        guard let count = textField.text?.count else { return }
        if count >= 3 {
            print("count > 3")
            NovaPoshta.loadSearchCity(search: textField.text) { (NovaPoshtaAnswer) in
                //1
            }
        }
        
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
        var shipingMethod = Delivery.InOffice.rawValue
    
        switch deliverySegmentedControl.selectedSegmentIndex {
        case 0:
            shipingMethod = Delivery.InOffice.rawValue
        case 1:
            shipingMethod = Delivery.NovaPoshta.rawValue
        case 2:
            shipingMethod = Delivery.Courier.rawValue
        default:
            break
        }
        
        var payMethod = PayMethod.Cash.rawValue
        
        switch paySegmentControll.selectedSegmentIndex {
        case 0:
            payMethod = PayMethod.Cash.rawValue
        case 1:
            payMethod = PayMethod.Privat.rawValue
        default:
            break
        }
        

//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            let shipingMethod = deliveryOptions[row] as String
//        }
        
        if InternetConnection.isConnectedToInternet && checkAllData() {
            var dataOrder = [
                "form": "XhfXlcpSQIAzbcW7LFDhYfDRIQD7Y-u8OBy_j2ayV_2weMSVRpTVZDS7pSAO5Ggvdzx6hYMoJGoj",
                "products": [
                    [
                        "id": Cart.shared.cartArrayItem[0].article,
                        "name": "",
                        "costPerItem": "",
                        "amount": Cart.shared.cartArrayItem[0].count
                    ]
                ],
                "comment": "Коментар введений вручну в API менеджері",
                "externalId": "",
                "fName": firstNameShopper.text!,
                "lName": secondNameShopper.text!,
                "phone": phoneShopper.text!,
                "email": "",
                "con_comment": "",
                "shipping_address": shippingAddress.text!,
                "shipping_method": shipingMethod,
                "payment_method": payMethod
                ] as [String : Any]
            
            Network.shared.passDataFromSalesDrive(data: dataOrder)
            
            Cart.shared.clearCart()
            if Cart.shared.cartArrayItem.isEmpty {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            UIAlertController.alert(title: "Не получиться", msg: "Пожалуйста, подключитесь к интернету", target: self)
        }
        
        //send to telegram
        //        if InternetConnection.isConnectedToInternet && checkAllData() {
        //            let apiToken = "861029744:AAF83m9tfZ1k8HnXteFsrJQYawEQdkMTAYo"
        //            let chatId = "@fixcenterOrder"
        //            var strUrl = "https://api.telegram.org/bot%@/sendMessage?chat_id=%@&text=%@"
        //
        //            strUrl = String(format: strUrl, apiToken, chatId, orderInformationForTelegram()!)
        //            let url = URL(string: strUrl)
        //            guard let newUrl = url else {return}
        //            let downloadTask = URLSession.shared.dataTask(with: newUrl) { (data : Data?, response : URLResponse?, error : Error?) in
        //            }
        //            downloadTask.resume()
        //
        //            Cart.shared.clearCart()
        //            if Cart.shared.cartArrayItem.isEmpty {
        //                self.dismiss(animated: true, completion: nil)
        //            }
        //        } else {
        //            UIAlertController.alert(title: "Не получиться", msg: "Пожалуйста, подключитесь к интернету", target: self)
        //        }
    }

    
    @IBAction func deliverySegmentControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            cityDelivery.isHidden = true
            postOfficeDeliveryr.isHidden = true
            shippingAddress.isHidden = true
            fixcenterAddress.isHidden = false
        case 1:
            cityDelivery.isHidden = false
            postOfficeDeliveryr.isHidden = false
            shippingAddress.isHidden = true
            fixcenterAddress.isHidden = true
        case 2:
            shippingAddress.isHidden = false
            postOfficeDeliveryr.isHidden = true
            cityDelivery.isHidden = true
            fixcenterAddress.isHidden = true
        default:
            break
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
