//
//  Authorization.swift
//  FIXER
//
//  Created by Per Pert on 3/12/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation

struct ResponseToken: Codable {
    let status: String
    let response: Answer
}

struct Answer: Codable {
    let token: String
}
