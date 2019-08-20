//
//  Menu.swift
//  FIXER
//
//  Created by Per Pert on 3/12/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation

struct MenuStruct: Codable {
    let status: String = ""
    let response: Response
}

struct Response: Codable {
    let pages: [Page]
}

struct Page: Codable {
    let id, parent: Int
//    let image: String?
    let title: Title
}

struct Title: Codable {
    let ru, ua: String
}

class Menu {
    var menu: [String:[String]]?
    
    func sortedMenu(response: [Page]) /*-> [String:[String?]]*/ {
        for i in response {
            if String(i.parent) == "1273" {
                for y in response{
                    if i.id.description == y.parent.description {
                        print(i.title.ua)
                        print(y.title.ua)
                        var array = [String]()
                        array.append(y.title.ua)
                        menu?.updateValue(array, forKey: i.title.ua)
                    }
                }
            }
        }
    }
}
 


