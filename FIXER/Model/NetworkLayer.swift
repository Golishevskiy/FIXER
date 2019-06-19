//
//  NetworkLayer.swift
//  FIXER
//
//  Created by Per Pert on 3/12/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation
import Alamofire

class Network: Codable {
    
    static let shared = Network()
    
    typealias EmptyClosure = (() -> Void)
    typealias exempleClosure = (() -> Void)
    let baseUrl = "https://fixcenter.com.ua/api"
    var token: String = ""
    var menuResp: MenuStruct!
    var items: AllResponse?
    
    func getToken(completion: EmptyClosure? = nil) {
        let authUrl = "/auth"
        let parametrs = ["login": "Petro", "password": "life210191"]
        guard let url = URL(string: baseUrl + authUrl) else { return }
        var reuest = URLRequest(url: url)
        reuest.httpMethod = "POST"
        reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
        reuest.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: reuest) { (data, response, error) in
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(ProductItem.self, from: data)
                self.token = response.response.token
                completion?()
                
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func loadMenu(completion: EmptyClosure? = nil) {
        let urlMenuStr = "/pages/export/"
        let parametrs = ["token": token, "parent": "1273"]
        guard let url = URL(string: baseUrl + urlMenuStr) else { return }
        
        var reuest = URLRequest(url: url)
        reuest.httpMethod = "POST"
        reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
        reuest.httpBody = httpBody
        
        URLSession.shared.dataTask(with: reuest) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let menu = try JSONDecoder().decode(MenuStruct.self, from: data)
                self.menuResp = menu
                completion?()
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func loadProduct(idCategory: String, completion: @escaping exempleClosure) {
        getToken()
        let urlProductStr = "/catalog/export/"
        let parametrs = ["token": token, "expr": ["parent": ["id": idCategory]]] as [String : Any]
        guard let url = URL(string: baseUrl + urlProductStr) else { return }
        
        var reuest = URLRequest(url: url)
        reuest.httpMethod = "POST"
        reuest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options:[]) else { return }
        reuest.httpBody = httpBody
        
        URLSession.shared.dataTask(with: reuest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let item = try JSONDecoder().decode(AllResponse.self, from: data)
                self.items = item
                completion()
            } catch {
                print(error)
            }
            }.resume()
    }
}

