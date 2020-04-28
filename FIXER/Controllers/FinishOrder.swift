//
//  FinishOrder.swift
//  FIXER
//
//  Created by Per Pert on 5/4/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit

protocol PassDataStreet: class {
    func passData(name: String)
}

protocol PassDataOffice: class {
    func passDataOffice(nameOffice: String)
}

class FinishOrder: UIViewController, PassData, PassDataStreet, PassDataOffice {
    
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
    
    private var deliveryMethod = ""
    private var deliveryOptions = [
        Delivery.InOffice.rawValue,
        Delivery.NovaPoshta.rawValue,
        Delivery.Courier.rawValue
    ]
    
    private var cityRef: String?
    private var postOfficeNumber: String?
    
    @IBAction func paymentMethod(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        deliveryMethod = Delivery.InOffice.rawValue
        cityDelivery.isHidden = true
        postOfficeDeliveryr.isHidden = true
        shippingAddress.isHidden = true
        fixcenterAddress.isHidden = false
//        postOfficeDeliveryr.isEnabled = true
        //for button finish order
        finishOrderButton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0, alpha: 1)
        finishOrderButton.setTitle("Оформить", for: .normal)
        finishOrderButton.layer.cornerRadius = finishOrderButton.frame.height / 2
        finishOrderButton.setTitleColor(.white, for: .normal)
        
        //Target
        cityDelivery.addTarget(self, action: #selector(goToSearchCityVC), for: .touchDown)
        postOfficeDeliveryr.addTarget(self, action: #selector(goToSearchOffice), for: .touchDown)
        shippingAddress.addTarget(self, action: #selector(goToSearchStretsVC), for: .touchDown)
    }
    
    func allItemToSalesDrive(itemArray: [ProductInCart]) -> [[String: Any]] {
        
        var dataItemSalesDrive = [[String: Any]].init()
        
        for i in itemArray {
            
            var item: [String: Any]
            item = ["id": i.article,
                    "amount": i.count
            ]
            
            dataItemSalesDrive.append(item)
        }
        
        return dataItemSalesDrive
    }
    
    @objc func goToSearchStretsVC() {
        performSegue(withIdentifier: "chooseStreetSegue", sender: nil)
    }
    
    @objc func goToSearchCityVC() {
        performSegue(withIdentifier: "NovaPoshtaCitiesSegue", sender: nil)
    }
    
    @objc func goToSearchOffice() {
        
        if cityRef != nil && cityRef != "" {
//            postOfficeDeliveryr.isEnabled = true
            performSegue(withIdentifier: "chooseOffice", sender: nil)
        } else {
            UIAlertController.alert(title: "Пожалуйста", msg: "Выберите город", target: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NovaPoshtaCitiesSegue" {
            guard let destination = segue.destination as? ChooseNovaPoshta else { return }
            destination.delegate = self
        }
        else if segue.identifier == "chooseStreetSegue" {
            guard let destination = segue.destination as? SearchStreetsVC else { return }
            destination.delegate = self
            
        }
        else if segue.identifier == "chooseOffice" {
            guard let destination = segue.destination as? SearchOfficeVC else { return }
            destination.cityRef = cityRef
            destination.delegate = self
        }
    }
    
    func passdataBack(id: String, name: String) {
        print("passed back \(id)")
        self.cityRef = id
        cityDelivery.text = name
    }
    
    func passData(name: String) {
        shippingAddress.placeholder = "г. Киев, \(name) "
    }
    
    func passDataOffice(nameOffice: String) {
        postOfficeDeliveryr.text = "Отделение №\(nameOffice)"
        postOfficeNumber = nameOffice
    }
    
    @objc func textFieldTyping(textField: UITextField) {
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
        
        let allItem = allItemToSalesDrive(itemArray: Cart.shared.cartArrayItem)
        // MARK: send order to salesDrive
        if InternetConnection.isConnectedToInternet && checkAllData() {
            let dataOrder = [
                "form": "XhfXlcpSQIAzbcW7LFDhYfDRIQD7Y-u8OBy_j2ayV_2weMSVRpTVZDS7pSAO5Ggvdzx6hYMoJGoj",
                "products": allItem,
                "comment": "Коментар введений вручну в API менеджері",
                "externalId": "",
                "fName": firstNameShopper.text!,
                "lName": secondNameShopper.text!,
                "phone": phoneShopper.text!,
                "email": "",
                "con_comment": "",
                "shipping_address": shippingAddress.text!,
                "shipping_method": shipingMethod,
                "payment_method": payMethod,
                "novaposhta": [
                    "ServiceType": "WarehouseWarehouse",
                    "city": cityDelivery.text!,
                    "WarehouseNumber": postOfficeNumber!,
                    "Street": "",
                    "BuildingNumber": "",
                    "Flat": "",
                    "backwardDeliveryCargoType": ""
                ]
                ] as [String : Any]
            
            Network.shared.passDataFromSalesDrive(data: dataOrder)
            
            Cart.shared.clearCart()
            if Cart.shared.cartArrayItem.isEmpty {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            UIAlertController.alert(title: "Не получиться", msg: "Пожалуйста, подключитесь к интернету", target: self)
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
