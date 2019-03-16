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
