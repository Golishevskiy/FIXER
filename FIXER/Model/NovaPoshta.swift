//
//  NovaPoschta.swift
//  FIXER
//
//  Created by Per Pert on 5/5/19.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation


struct NovaPoshta {
    let allDepartment = [Department]()
}

class Department: Codable {
    let ref, typeOfWarehouse, warehouseTypeDescription, cityRu: String
    let cityRef, addressRu: String
    
    enum CodingKeys: String, CodingKey {
        case ref
        case typeOfWarehouse = "TypeOfWarehouse"
        case warehouseTypeDescription, cityRu
        case cityRef = "city_ref"
        case addressRu
    }
    
    init(ref: String, typeOfWarehouse: String, warehouseTypeDescription: String, cityRu: String, cityRef: String, addressRu: String) {
        self.ref = ref
        self.typeOfWarehouse = typeOfWarehouse
        self.warehouseTypeDescription = warehouseTypeDescription
        self.cityRu = cityRu
        self.cityRef = cityRef
        self.addressRu = addressRu
    }
}


