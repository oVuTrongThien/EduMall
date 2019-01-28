//
//  APIError.swift
//  EduMall
//
//  Created by vu trong thien on 1/28/19.
//  Copyright © 2019 vu trong thien. All rights reserved.
//

enum APIError: Error {
    case invalidURL(url: String)
    case invalidResponseData(data: Any)
    case error(responseCode: Int, data: Any)
}

enum ResponseError: Error {
    case noStatusCode
    case invalidData(data: Any?)
    case unknown(statusCode: Int)
    case notModified // 304
    case invalidRequest // 400
    case unauthorized // 401
    case accessDenied // 403
    case notFound  // 404
    case methodNotAllowed  // 405
    case isFriend  // 406
    case validate   // 422
    case forceUpdate(version: Int, installedUrl: String) // 426
    case serverError // 500
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
}
