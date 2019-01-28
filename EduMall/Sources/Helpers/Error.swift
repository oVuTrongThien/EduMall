//
//  Error.swift
//  EduMall
//
//  Created by vu trong thien on 1/28/19.
//  Copyright © 2019 vu trong thien. All rights reserved.
//

import Foundation

import Foundation

final class EduMallError: Error {
    var code: ErrorCode?
    var message: String?
    var domain: String?

    init(code: ErrorCode?, message: String?, domain: String? = Domain.UserDomain) {
        self.code = code
        self.message = message
        self.domain = domain
    }

    struct Domain {
        static let NetworkDomain = "NetworkDomain"
        static let UserDomain = "UserDomain"
    }

    enum ErrorCode: Int {
        case succeeded
        case failure
        case networkError
        case ioError
        case generalError
        case fatalError
    }
}
