//
//  Utilities.swift
//  EduMall
//
//  Created by vu trong thien on 1/28/19.
//  Copyright © 2019 vu trong thien. All rights reserved.
//

import Foundation
import Reachability

class Utilities {

    static func isInternetAvailable() -> Bool {
       return Reachability()?.connection != Reachability.Connection.none
    }

}
