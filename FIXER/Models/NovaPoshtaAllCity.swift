//
//  NovaPoshtaAllCity.swift
//  FIXER
//
//  Created by Per Pert on 6/21/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation

class NovaPoshta {
    
    var npAll = [String: [String]]()
    var cityArray = [String].init()
    
    class func searchStreets(streetName name: String?, completion: @escaping (([Street]) -> Void)) {
        let json: [String: Any] = [ "apiKey": ApiKeyNP.key.rawValue,
                                    "modelName": "Address",
                                    "calledMethod": "searchSettlementStreets",
                                    "methodProperties": [
                                        "StreetName": name,
                                        "SettlementRef": "e718a680-4b33-11e4-ab6d-005056801329",
                                        "Limit": 15
            ]
        ]
        
        let JSONData = try? JSONSerialization.data(withJSONObject: json)
        let urlString = URL(string: Url.novaPoshta.rawValue)
        guard let url = urlString else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = JSONData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let streets = try? JSONDecoder().decode(StreetsModel.self, from: data)
            guard let answer = streets?.success else { return }
            if answer {
                guard let resulData = streets?.data![0] else { return }
                let result = resulData
                guard let sendData = result.addresses else { return }
                completion(sendData)
            }
            
        }.resume()
        
    }
    
    class func loadAllOfficeInCity(cityRef: String, completion: @escaping ([Datum]) -> Void) {
        let json: [String: Any] = ["modelName": "AddressGeneral",
                                   "calledMethod": "getWarehouses",
                                   "methodProperties": [
                                    "CityRef": cityRef
            ],
                                   "apiKey": ApiKeyNP.key.rawValue
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let urlString = URL(string: Url.novaPoshta.rawValue)
        guard let url = urlString else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let officeInCity =  try? JSONDecoder().decode(ResultSearchModel.self, from: data)
            guard let offices = officeInCity?.data else { return }
            completion(offices)
        }.resume()
    }
    
    class func loadSearchCity(search: String?, completion: @escaping (ResultSearchNovaPoshta) -> Void) {
        let json: [String: Any] = ["modelName": "Address",
                                   "calledMethod": "getCities",
                                   "methodProperties": [
                                    "FindByString": search
            ],
                                   "apiKey": ApiKeyNP.key.rawValue
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: Url.novaPoshta.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let result = try? JSONDecoder().decode(ResultSearchNovaPoshta.self, from: data)
            guard let resp = result else { return }
            completion(resp)
        }.resume()
    }
}

