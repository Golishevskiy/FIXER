//
//  NetworkLayer.swift
//  FIXER
//
//  Created by Per Pert on 3/12/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation

class Network: Codable {
    typealias EmptyClosure = (() -> Void)
    let baseUrl = "https://fixcenter.com.ua/api"
    private var one: String = ""
    var menuResp: MenuStruct!
    
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
                self.one = response.response.token
                completion?()
                
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func loadMenu() {
        let urlMenuStr = "/pages/export/"
        let parametrs = ["token": one, "parent": "1273"]
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
            } catch {
                print(error)
            }
            }.resume()
    }
    
    
}



