//
//  ModelNovaPoshta.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 13.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import Foundation

struct NovaPoshtaAnswer : Codable {
    let success : Bool?
    let data : [Cities]
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
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        success = try values.decodeIfPresent(Bool.self, forKey: .success)
//        data = try values.decodeIfPresent([Cities].self, forKey: .data)
//        errors = try values.decodeIfPresent([String].self, forKey: .errors)
//        warnings = try values.decodeIfPresent([String].self, forKey: .warnings)
//        info = try values.decodeIfPresent([String].self, forKey: .info)
//        messageCodes = try values.decodeIfPresent([String].self, forKey: .messageCodes)
//        errorCodes = try values.decodeIfPresent([String].self, forKey: .errorCodes)
//        warningCodes = try values.decodeIfPresent([String].self, forKey: .warningCodes)
//        infoCodes = try values.decodeIfPresent([String].self, forKey: .infoCodes)
//    }

}


struct Cities : Codable {
    let totalCount : Int?
    let addresses : [City]

    enum CodingKeys: String, CodingKey {

        case totalCount = "TotalCount"
        case addresses = "Addresses"
    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
//        addresses = try values.decodeIfPresent([City].self, forKey: .addresses)
//    }

}
struct City : Codable {
    let present : String?
    let warehouses : Int?
    let mainDescription : String?
    let area : String?
    let region : String?
    let settlementTypeCode : String?
    let ref : String?
    let deliveryCity : String?
    let streetsAvailability : Bool?
    let parentRegionTypes : String?
    let parentRegionCode : String?
    let regionTypes : String?
    let regionTypesCode : String?

    enum CodingKeys: String, CodingKey {

        case present = "Present"
        case warehouses = "Warehouses"
        case mainDescription = "MainDescription"
        case area = "Area"
        case region = "Region"
        case settlementTypeCode = "SettlementTypeCode"
        case ref = "Ref"
        case deliveryCity = "DeliveryCity"
        case streetsAvailability = "StreetsAvailability"
        case parentRegionTypes = "ParentRegionTypes"
        case parentRegionCode = "ParentRegionCode"
        case regionTypes = "RegionTypes"
        case regionTypesCode = "RegionTypesCode"
    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        present = try values.decodeIfPresent(String.self, forKey: .present)
//        warehouses = try values.decodeIfPresent(Int.self, forKey: .warehouses)
//        mainDescription = try values.decodeIfPresent(String.self, forKey: .mainDescription)
//        area = try values.decodeIfPresent(String.self, forKey: .area)
//        region = try values.decodeIfPresent(String.self, forKey: .region)
//        settlementTypeCode = try values.decodeIfPresent(String.self, forKey: .settlementTypeCode)
//        ref = try values.decodeIfPresent(String.self, forKey: .ref)
//        deliveryCity = try values.decodeIfPresent(String.self, forKey: .deliveryCity)
//        streetsAvailability = try values.decodeIfPresent(Bool.self, forKey: .streetsAvailability)
//        parentRegionTypes = try values.decodeIfPresent(String.self, forKey: .parentRegionTypes)
//        parentRegionCode = try values.decodeIfPresent(String.self, forKey: .parentRegionCode)
//        regionTypes = try values.decodeIfPresent(String.self, forKey: .regionTypes)
//        regionTypesCode = try values.decodeIfPresent(String.self, forKey: .regionTypesCode)
//    }

}
