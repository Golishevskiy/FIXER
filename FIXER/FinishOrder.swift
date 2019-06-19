//
//  FinishOrder.swift
//  FIXER
//
//  Created by Per Pert on 5/4/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import UIKit
import Alamofire



struct NovaPoshtaNumber: Codable {
    let data: [Datum1]
}

// MARK: - Datum
struct Datum1: Codable {
    let siteKey, datumDescription, shortAddress, number: String
    let cityDescription: String
    
    enum CodingKeys: String, CodingKey {
        case siteKey
        case datumDescription
        case shortAddress
        case number
        case cityDescription
    }
}

// MARK: - NovaPoshta
struct NovaPoshta1: Decodable {
    let success: Bool
    let data: [Datum]
    let errors, warnings: [JSONAny]
    let info: Info
    let messageCodes, errorCodes, warningCodes, infoCodes: [JSONAny]
}

// MARK: - Datum
struct Datum: Decodable {
    let datumDescription, descriptionRu, ref, delivery1: String
    let delivery2, delivery3, delivery4, delivery5: String
    let delivery6, delivery7, area, settlementType: String
    let isBranch: String
    let preventEntryNewStreetsUser: JSONNull?
    let conglomerates: [String]?
    let cityID: String
    let settlementTypeDescription: SettlementTypeDescription
    let settlementTypeDescriptionRu: SettlementTypeDescriptionRu
    let specialCashCheck: Int
    
    enum CodingKeys: String, CodingKey {
        case datumDescription = "Description"
        case descriptionRu = "DescriptionRu"
        case ref = "Ref"
        case delivery1 = "Delivery1"
        case delivery2 = "Delivery2"
        case delivery3 = "Delivery3"
        case delivery4 = "Delivery4"
        case delivery5 = "Delivery5"
        case delivery6 = "Delivery6"
        case delivery7 = "Delivery7"
        case area = "Area"
        case settlementType = "SettlementType"
        case isBranch = "IsBranch"
        case preventEntryNewStreetsUser = "PreventEntryNewStreetsUser"
        case conglomerates = "Conglomerates"
        case cityID = "CityID"
        case settlementTypeDescription = "SettlementTypeDescription"
        case settlementTypeDescriptionRu = "SettlementTypeDescriptionRu"
        case specialCashCheck = "SpecialCashCheck"
    }
}

enum SettlementTypeDescription: String, Decodable {
    case місто = "місто"
    case селище = "селище"
    case селищеМіськогоТипу = "селище міського типу"
    case село = "село"
}

enum SettlementTypeDescriptionRu: String, Decodable {
    case город = "город"
    case поселок = "поселок"
    case поселокГородскогоТипа = "поселок городского типа"
    case село = "село"
}

// MARK: - Info
struct Info: Decodable {
    let totalCount: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Decodable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


class FinishOrder: UIViewController {
    
    @IBAction func cancel(_ sender: UIButton) {
        
        // prepare json data
//        let json: [String: Any] = ["modelName": "Address",
//                                   "calledMethod": "getCities",
//                                   "methodProperties": ["" : ""],
//                                   "apiKey": "bde180dca59155e550084a261a90e69e"]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        // create post request
//        let url = URL(string: "https://api.novaposhta.ua/v2.0/json/")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // insert json data to the request
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//
//            do {
//                let responseJSON = try JSONDecoder().decode(NovaPoshta1.self, from: data)
//                print("-------------------------------")
//                print(responseJSON.data.count)
//                for i in responseJSON.data {
//                    print(i.datumDescription)
//                }
//                print("-------------------------------")
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
        
        
        
        // prepare json data
        let jsonOFCity: [String: Any] = ["modelName": "AddressGeneral",
                                         "calledMethod": "getWarehouses",
                                         "methodProperties": [
                                            "Language": "ru",
                                            "CityName": "Попільня"
            ],
                                         "apiKey": "bde180dca59155e550084a261a90e69e"]
        
        let jsonData1 = try? JSONSerialization.data(withJSONObject: jsonOFCity)
        
        // create post request
        let urlCity = URL(string: "https://api.novaposhta.ua/v2.0/json/")!
        var requestCity = URLRequest(url: urlCity)
        requestCity.httpMethod = "POST"
        
        // insert json data to the request
        requestCity.httpBody = jsonData1
        
        let taskCity = URLSession.shared.dataTask(with: requestCity) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            do {
                let responseJSON = try JSONDecoder().decode(NovaPoshtaNumber.self, from: data)
                print("-------------------------------")
                print(responseJSON.data[0].datumDescription)
                print("-------------------------------")
            } catch {
                print(error)
            }
        }
        taskCity.resume()
        
        
    }
}

