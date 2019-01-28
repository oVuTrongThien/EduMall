//
//  APIInputBase.swift
//  EduMall
//
//  Created by vu trong thien on 1/28/19.
//  Copyright © 2019 vu trong thien. All rights reserved.
//

import Alamofire

class APIUploadFile {
    let data: Data?
    let key: String?
    let fileName: String?
    let mimeType: String?
    init(key: String, data: Data, fileName: String, mimeType: String) {
        self.key = key
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

class APIInputBase {
    var headers: [String: String]?
    var host: String?
    var path: String?
    var urlString: String
    let requestType: HTTPMethod
    var encoding: ParameterEncoding
    let parameters: [String: Any]?
    let requireAccessToken: Bool
    var isCache = false
    var timeout = Constant.timeout

    convenience init(host: String, path: String?, parameters: [String: Any]?, requestType: HTTPMethod,
                     requireAccessToken: Bool = true, isCache: Bool = false) {
        var urlString: String
        if let `path` = path {
            urlString = host + path
        } else {
            urlString = host
        }
        self.init(urlString: urlString, parameters: parameters, requestType: requestType,
                  requireAccessToken: requireAccessToken, isCache: isCache)
        self.host = host
        self.path = path
    }

    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod,
         requireAccessToken: Bool = true, isCache: Bool = false) {
        if let cookies = HTTPCookieStorage.shared.cookies {
            self.headers = HTTPCookie.requestHeaderFields(with: cookies)
            self.headers?["Content-Type"] = "application/json; charset=utf-8"
            self.headers?["Accept"] = "application/json"
        }
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.requireAccessToken = requireAccessToken
        self.isCache = isCache
        self.urlString = urlString

    }
}
