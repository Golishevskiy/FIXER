//
//  Product.swift
//  FIXER
//
//  Created by Per Pert on 3/16/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation

struct AllResponse: Codable {
    let status: String
    let response: ResponseProduct
}

struct ResponseProduct: Codable {
    let products: [Product]
}

struct Product: Codable {
    let parentArticle, article: String
    let price: Double
    let presence: Presence
    let shortDescription, title: Description
    let parent: Parent
    let description: Description
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case parentArticle = "parent_article"
        case article, price, presence
        case shortDescription = "short_description"
        case title, parent, description, images
    }
}

struct Description: Codable {
    let ru, ua: String
}

struct Parent: Codable {
    let id: Int
    let value: String
}

struct Presence: Codable {
    let id: Int
    let value: Description
}
