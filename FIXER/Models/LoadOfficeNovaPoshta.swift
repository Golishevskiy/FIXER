//
//  LoadOfficeNovaPoshta.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 14.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import Foundation


class LoadOfficeNovaPoshta: AsynchronousOperation {
     
    private var cityRef: String
    private var completion: ([Datum]) -> Void
    
    init(city: String, closure: @escaping ([Datum]) -> Void) {
        self.cityRef = city
        self.completion = closure
    }
    
    override func execute() {
        NovaPoshta.loadAllOfficeInCity(cityRef: cityRef) { [weak self] (data) in
            guard let self = self else { return }
            self.completion(data)
            self.finish()
        }
    }
}
