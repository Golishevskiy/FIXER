//
//  StreetsModel.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 19.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import Foundation

struct StreetsModel: Codable {
    
    let success : Bool?
    let data : [ResultSearchStreet]?
    let errors : [String]?
    let warnings : [String]?
    let info : [String]?
    let messageCodes : [String]?
    let errorCodes : [String]?
    let warningCodes : [String]?
    let infoCodes : [String]?
    
    enum CodingKeys: String, CodingKey {

          case success = "success"
          case data = "data"
          case errors = "errors"
          case warnings = "warnings"
          case info = "info"
          case messageCodes = "messageCodes"
          case errorCodes = "errorCodes"
          case warningCodes = "warningCodes"
          case infoCodes = "infoCodes"
      }
    
    
}

struct ResultSearchStreet: Codable {
    
    let totalCount: Int?
    let addresses: [Street]?
    
    enum CodingKeys: String, CodingKey {

          case totalCount = "TotalCount"
          case addresses = "Addresses"
      }
}

struct Street: Codable {
    let present: String
    
    enum CodingKeys: String, CodingKey {
        case present = "Present"
    }
}







//{
//    "success": true,
//    "data": [
//        {
//            "TotalCount": 4,
//            "Addresses": [
//                {
//                    "SettlementRef": "e718a680-4b33-11e4-ab6d-005056801329",
//                    "SettlementStreetRef": "7a4d5afb-6846-11e6-8304-00505688561d",
//                    "SettlementStreetDescription": "Львівська",
//                    "Present": "вул. Львівська",
//                    "StreetsType": "0f1d7fbb-4bba-11e4-ab6d-005056801329",
//                    "StreetsTypeDescription": "вул.",
//                    "Location": [
//                        50.454428773373003,
//                        30.372133422643
//                    ],
//                    "SettlementStreetDescriptionRu": "Львовская"
//                },
//                {
//                    "SettlementRef": "e718a680-4b33-11e4-ab6d-005056801329",
//                    "SettlementStreetRef": "075ce3d3-6851-11e6-8304-00505688561d",
//                    "SettlementStreetDescription": "Толстого Льва",
//                    "Present": "вул. Толстого Льва",
//                    "StreetsType": "0f1d7fbb-4bba-11e4-ab6d-005056801329",
//                    "StreetsTypeDescription": "вул.",
//                    "Location": [
//                        50.441388962790001,
//                        30.504513932392001
//                    ],
//                    "SettlementStreetDescriptionRu": "Толстого Льва"
//                },
//                {
//                    "SettlementRef": "e718a680-4b33-11e4-ab6d-005056801329",
//                    "SettlementStreetRef": "dc0ed060-6845-11e6-8304-00505688561d",
//                    "SettlementStreetDescription": "Львівська",
//                    "Present": "пл. Львівська",
//                    "StreetsType": "0f1d830c-4bba-11e4-ab6d-005056801329",
//                    "StreetsTypeDescription": "пл.",
//                    "Location": [
//                        50.454845982603999,
//                        30.506319981068
//                    ],
//                    "SettlementStreetDescriptionRu": "Львовская"
//                },
//                {
//                    "SettlementRef": "e718a680-4b33-11e4-ab6d-005056801329",
//                    "SettlementStreetRef": "2771557a-684a-11e6-8304-00505688561d",
//                    "SettlementStreetDescription": "Толстого Льва",
//                    "Present": "пл. Толстого Льва",
//                    "StreetsType": "0f1d830c-4bba-11e4-ab6d-005056801329",
//                    "StreetsTypeDescription": "пл.",
//                    "Location": [
//                        50.439220983535002,
//                        30.516218924895
//                    ],
//                    "SettlementStreetDescriptionRu": "Толстого Льва"
//                }
//            ]
//        }
//    ],
//    "errors": [],
//    "warnings": [],
//    "info": [],
//    "messageCodes": [],
//    "errorCodes": [],
//    "warningCodes": [],
//    "infoCodes": []
//}
