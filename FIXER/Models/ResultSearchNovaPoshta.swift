//
//  ResultSearchNovaPoshta.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 19.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import Foundation

struct ResultSearchNovaPoshta : Codable {
    let success : Bool?
    let data : [ResultCity]?
    let errors : [String]?
    let warnings : [String]?
    let info : Inform?
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

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        success = try values.decodeIfPresent(Bool.self, forKey: .success)
//        data = try values.decodeIfPresent([ResultCity].self, forKey: .data)
//        errors = try values.decodeIfPresent([String].self, forKey: .errors)
//        warnings = try values.decodeIfPresent([String].self, forKey: .warnings)
//        info = try values.decodeIfPresent(Inform.self, forKey: .info)
//        messageCodes = try values.decodeIfPresent([String].self, forKey: .messageCodes)
//        errorCodes = try values.decodeIfPresent([String].self, forKey: .errorCodes)
//        warningCodes = try values.decodeIfPresent([String].self, forKey: .warningCodes)
//        infoCodes = try values.decodeIfPresent([String].self, forKey: .infoCodes)
//    }

}


struct ResultCity : Codable {
    let description : String?
    let descriptionRu : String?
    let ref : String?
//    let delivery1 : String?
//    let delivery2 : String?
//    let delivery3 : String?
//    let delivery4 : String?
//    let delivery5 : String?
//    let delivery6 : String?
//    let delivery7 : String?
//    let area : String?
    let settlementType : String?
//    let isBranch : String?
//    let preventEntryNewStreetsUser : Bool?
//    let conglomerates : String?
//    let cityID : String?
//    let settlementTypeDescriptionRu : String?
//    let settlementTypeDescription : String?
//    let specialCashCheck : Int?
//    let postomat : Int?

    enum CodingKeys: String, CodingKey {

        case description = "Description"
        case descriptionRu = "DescriptionRu"
        case ref = "Ref"
//        case delivery1 = "Delivery1"
//        case delivery2 = "Delivery2"
//        case delivery3 = "Delivery3"
//        case delivery4 = "Delivery4"
//        case delivery5 = "Delivery5"
//        case delivery6 = "Delivery6"
//        case delivery7 = "Delivery7"
//        case area = "Area"
        case settlementType = "SettlementType"
//        case isBranch = "IsBranch"
//        case preventEntryNewStreetsUser = "PreventEntryNewStreetsUser"
//        case conglomerates = "Conglomerates"
//        case cityID = "CityID"
//        case settlementTypeDescriptionRu = "SettlementTypeDescriptionRu"
//        case settlementTypeDescription = "SettlementTypeDescription"
//        case specialCashCheck = "SpecialCashCheck"
//        case postomat = "Postomat"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        descriptionRu = try values.decodeIfPresent(String.self, forKey: .descriptionRu)
//        ref = try values.decodeIfPresent(String.self, forKey: .ref)
//        delivery1 = try values.decodeIfPresent(String.self, forKey: .delivery1)
//        delivery2 = try values.decodeIfPresent(String.self, forKey: .delivery2)
//        delivery3 = try values.decodeIfPresent(String.self, forKey: .delivery3)
//        delivery4 = try values.decodeIfPresent(String.self, forKey: .delivery4)
//        delivery5 = try values.decodeIfPresent(String.self, forKey: .delivery5)
//        delivery6 = try values.decodeIfPresent(String.self, forKey: .delivery6)
//        delivery7 = try values.decodeIfPresent(String.self, forKey: .delivery7)
//        area = try values.decodeIfPresent(String.self, forKey: .area)
//        settlementType = try values.decodeIfPresent(String.self, forKey: .settlementType)
//        isBranch = try values.decodeIfPresent(String.self, forKey: .isBranch)
//        preventEntryNewStreetsUser = ((try values.decodeIfPresent(String.self, forKey: .preventEntryNewStreetsUser)) != nil)
//        conglomerates = try values.decodeIfPresent(String.self, forKey: .conglomerates)
//        cityID = try values.decodeIfPresent(String.self, forKey: .cityID)
//        settlementTypeDescriptionRu = try values.decodeIfPresent(String.self, forKey: .settlementTypeDescriptionRu)
//        settlementTypeDescription = try values.decodeIfPresent(String.self, forKey: .settlementTypeDescription)
//        specialCashCheck = try values.decodeIfPresent(Int.self, forKey: .specialCashCheck)
//        postomat = try values.decodeIfPresent(Int.self, forKey: .postomat)
//    }

}

struct Inform : Codable {
    let totalCount : Int?

    enum CodingKeys: String, CodingKey {

        case totalCount = "totalCount"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
//    }
}

