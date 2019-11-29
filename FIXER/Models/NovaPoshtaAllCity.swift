////
////  NovaPoshtaAllCity.swift
////  FIXER
////
////  Created by Per Pert on 6/21/19.
////  Copyright © 2019 Petro. All rights reserved.
////
//
//import Foundation
//
//class NovaPoshta {
//
//    static let shared = NovaPoshta()
//
//    var npAll = [String: [String]]()
//    var cityArray = [String].init()
//    var answerNP = JSON() 
//
//    // Load all city and add to array cityArray
//    func loadCityList() {
//        //load all City
//        let json: [String: Any] = ["modelName": "Address",
//                                   "calledMethod": "getCities",
//                                   "methodProperties": ["" : ""],
//                                   "apiKey": "bde180dca59155e550084a261a90e69e"]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        // create post request
//        let url = URL(string: "https://api.novaposhta.ua/v2.0/json/")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // insert json data to the request
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//
//            let resulAllCity = JSON(data)
//            let linkCityArray = resulAllCity["data"]
//            for i in 0..<linkCityArray.count {
//                self.cityArray.append(linkCityArray[i]["Description"].stringValue)
//            }
//        }
//        task.resume()
//    }
//
//    func loadPosTOffice() {
//        let jsonOFCity: [String: Any] = [ "modelName": "AddressGeneral",
//                                          "calledMethod": "getWarehouses",
//                                          "methodProperties": ["":""],
//                                          "apiKey": "bde180dca59155e550084a261a90e69e"]
//
//        let jsonData1 = try? JSONSerialization.data(withJSONObject: jsonOFCity)
//        let urlCity = URL(string: "https://api.novaposhta.ua/v2.0/json/")!
//
//        // create post request
//        var requestCity = URLRequest(url: urlCity)
//        requestCity.httpMethod = "POST"
//
//        // insert json data to the request
//        requestCity.httpBody = jsonData1
//
//        let taskCity = URLSession.shared.dataTask(with: requestCity) { (data, response, error) in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            var value = JSON(data)
//            print(value["data"].arrayValue.count)
//
//            for i in 0...value["data"].arrayValue.count {
//                let key = value["data"][i]["CityDescription"].stringValue
//                let valuePost = value["data"][i]["ShortAddress"].stringValue
//                print(key)
//                self.npAll.updateValue([valuePost], forKey: key)
//            }
//        }
//        taskCity.resume()
//    }
//}
//
