//
//  LoadStreetsKyivOperation.swift
//  FIXER
//
//  Created by Petro GOLISHEVSKIY on 19.04.2020.
//  Copyright © 2020 Petro. All rights reserved.
//

import Foundation


class LoadStreetsKyivOperation: AsynchronousOperation {
    
    let streetName: String?
    let completion: ([Street]) -> Void
    
    init(searchStreet: String, closure: @escaping ([Street]) -> Void ) {
        self.streetName = searchStreet
        self.completion = closure
    }
    
    override func execute() {
        NovaPoshta.searchStreets(streetName: streetName) { [weak self] (streetArray) in
            guard let self = self else { return }
            self.completion(streetArray)
            self.finish()
        }
    }
}
