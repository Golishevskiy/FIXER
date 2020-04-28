//
//  ResultSearchModel.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 14.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import Foundation

// MARK: - ResultSearchModel
struct ResultSearchModel: Codable {
    let success: Bool?
    let data: [Datum]?
    let errors, warnings: [String]?
    let info: Info?
    let messageCodes, errorCodes, warningCodes, infoCodes: [String]?
}

// MARK: - Datum
struct Datum: Codable {
//    let siteKey, datumDescription, descriptionRu, shortAddress: String?
    let descriptionRu: String?
    let shortAddress: String?
    let ref: String?
    let shortAddressRu: String?
//    let shortAddressRu, phone, typeOfWarehouse, ref: String?
    let number: String?
//    , cityRef, cityDescription, cityDescriptionRu: String?
//    let settlementRef, settlementDescription, settlementAreaDescription, settlementRegionsDescription: String?
//    let settlementTypeDescription, longitude, latitude, postFinance: String?
//    let bicycleParking, paymentAccess, posTerminal, internationalShipping: String?
//    let selfServiceWorkplacesCount: String?

//    let districtCode, warehouseStatus, warehouseStatusDate, categoryOfWarehouse: String?
//    let direct: String?

    enum CodingKeys: String, CodingKey {
//        case siteKey
//        case datumDescription
        case descriptionRu = "DescriptionRu"
        case shortAddress = "ShortAddress"
        case shortAddressRu = "ShortAddressRu"
//        case phone
//        case typeOfWarehouse
        case ref = "Ref"
        case number = "Number"
//        case cityRef
//        case cityDescription
//        case cityDescriptionRu
//        case settlementRef
//        case settlementDescription
//        case settlementAreaDescription
//        case settlementRegionsDescription
//        case settlementTypeDescription
//        case longitude
//        case latitude
//        case postFinance
//        case bicycleParking
//        case paymentAccess
//        case posTerminal
//        case internationalShipping
//        case selfServiceWorkplacesCount
//        case totalMaxWeightAllowed
//        case placeMaxWeightAllowed
//        case reception
//        case delivery
//        case schedule
//        case districtCode
//        case warehouseStatus
//        case warehouseStatusDate
//        case categoryOfWarehouse
//        case direct
    }
}

// MARK: - Info
struct Info: Codable {
    let totalCount: Int?
}
