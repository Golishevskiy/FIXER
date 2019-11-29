//
//  InternetConnection.swift
//  FIXER
//
//  Created by Per Pert on 16.11.2019.
//  Copyright © 2019 Petro. All rights reserved.
//

import Foundation
import Alamofire

class InternetConnection {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

