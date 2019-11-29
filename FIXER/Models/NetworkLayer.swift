//
//  NetworkLayer.swift
//  FIXER
//
//  Created by Per Pert on 3/12/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation

class Network: Codable {
    
    static let shared = Network()
    
    typealias EmptyClosure = (() -> Void)
    typealias exempleClosure = ((AllResponse) -> Void)
    typealias Closure = ((MenuStruct) -> Void)
//    typealias Closure<T> = ((T) -> Void)
    var token: String?
    
    
    let a  = Url.catalog.rawValue
    
    
    func getToken(completion: EmptyClosure? = nil) {
        let parametrs = ["login": "Petro", "password": "life210191"]
        guard let url = URL(string: Url.base.rawValue + Url.auth.rawValue) else { return }
        var reuest = URLRequest(url: url)
        reuest.httpMethod = "POST"
        reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
        reuest.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: reuest) { (data, response, error) in
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(ResponseToken.self, from: data)
                self.token = response.response.token
                completion?()
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func loadMenu(completion: @escaping Closure) {
        guard let token = self.token else { return }
        let parametrs = ["token": token, "parent": "1273"]
        guard let url = URL(string: Url.base.rawValue + Url.menu.rawValue) else { return }
        
        var reuest = URLRequest(url: url)
        reuest.httpMethod = "POST"
        reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
        reuest.httpBody = httpBody
        
        URLSession.shared.dataTask(with: reuest) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let menu = try JSONDecoder().decode(MenuStruct.self, from: data)
                completion(menu)
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func loadProduct(idCategory: String, completion: @escaping exempleClosure) {
        getToken()
        guard let token = self.token else { return }
        let parametrs = ["token": token, "expr": ["parent": ["id": idCategory]]] as [String : Any]
        guard let url = URL(string: Url.base.rawValue + Url.catalog.rawValue) else { return }
        
        var reuest = URLRequest(url: url)
        reuest.httpMethod = "POST"
        reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
        reuest.httpBody = httpBody
        
        URLSession.shared.dataTask(with: reuest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let item = try JSONDecoder().decode(AllResponse.self, from: data)
                completion(item)
            } catch {
                print(error)
            }
            }.resume()
    }
    
//    func loadData<T>(model: T.Type, urlString: String, type: T.Type, completion: @escaping Closure<T>) where T: Decodable  {
//
//            guard let token = self.token else { return }
//            let parametrs = ["token": token, "parent": "1273"]
//            let url = URL(string: urlString)
//
//            var reuest = URLRequest(url: url!)
//            reuest.httpMethod = "POST"
//            reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
//            reuest.httpBody = httpBody
//
//            URLSession.shared.dataTask(with: reuest) { (data, response, error) in
//                guard let data = data else { return }
//
//                do {
//                    let result = try JSONDecoder().decode(model, from: data)
//                    completion(result)
//                } catch {
//                    print(error)
//                }
//                }.resume()
//        }
    }



