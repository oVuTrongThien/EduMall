//
//  APIService.swift
//  EduMall
//
//  Created by vu trong thien on 1/28/19.
//  Copyright © 2019 vu trong thien. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxAlamofire
import Himotoki

class APIService: NSObject {
    fileprivate var manager = SessionManager.default

    fileprivate func _request(_ input: APIInputBase) -> Observable<Any> {
        let urlRequest = configRequest(input)
        let managerConfiguration = URLSessionConfiguration.default
        managerConfiguration.timeoutIntervalForRequest = input.timeout
        managerConfiguration.timeoutIntervalForResource = input.timeout
        manager = Alamofire.SessionManager(configuration: managerConfiguration)

        return manager
            .rx
            .request(urlRequest: urlRequest!)
            .flatMap { dataRequest -> Observable<DataResponse<Any>> in
                if input.isCache && Utilities.isInternetAvailable() {
                    dataRequest.responseData(queue: DispatchQueue.global(qos: .background), completionHandler: { (response) in
                        if let urlRequest = urlRequest,
                            let res = response.response,
                            let data = response.data,
                            200..<300 ~= res.statusCode {
                            let cachedURLResponse = CachedURLResponse(response: res, data: data, userInfo: nil, storagePolicy: .allowed)
                            URLCache.shared.storeCachedResponse(cachedURLResponse, for: urlRequest)
                        }
                    })
                }
                return dataRequest.rx.responseJSON()
            }
            .map { dataResponse -> Any in
                return try self.process(dataResponse)
        }
    }

    fileprivate func configRequest(_ input: APIInputBase) -> URLRequest? {
        var urlRequest: URLRequest
        var data: Data?

        guard var url = URL(string: input.urlString) else {
            return nil
        }
        if let parameters = input.parameters {
            if input.requestType != .get {
                do {
                    data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                } catch {
                }
            } else {
                if let urlValue = createURLWithComponents(urlString: input.urlString, params: parameters) {
                    url = urlValue
                }
            }
        }
        if input.isCache && !Utilities.isInternetAvailable() {
            urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: input.timeout)
        } else {
            urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: input.timeout)
        }

        urlRequest.httpMethod = input.requestType.rawValue
        urlRequest.allHTTPHeaderFields = input.headers
        if let data = data {
            urlRequest.httpBody = data
        }

        return urlRequest
    }

    fileprivate func createURLWithComponents(urlString: String, params: [String: Any]) -> URL? {
        var urlComponents = URLComponents(string: urlString)
        // add params
        urlComponents?.queryItems = []
        for param in params {
            let value = String(describing: param.value)
            let query = URLQueryItem(name: param.key, value: value)
            urlComponents?.queryItems?.append(query)
        }
        return urlComponents?.url
    }

    // swiftlint:disable cyclomatic_complexity
    fileprivate func process(_ response: DataResponse<Any>) throws -> Any {
        let error: Error
        switch response.result {
        case .success(let value):
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200..<300:
                    // TODO: Force logout
                    return value
                default:
                    if let responseError = APIService.processErrorFrom(response) {
                        error = responseError
                    } else {
                        error = ResponseError.noStatusCode
                    }
                }
            } else {
                if response.response?.statusCode == nil { // when cache value
                    return value
                } else {
                    error = ResponseError.noStatusCode
                }
            }
            print(value)
        case .failure(let e):
            error = e
        }
        throw error
    }

    static func processErrorFrom(_ response: DataResponse<Any>) -> Error? {
        let error: Error?
        guard let statusCode = response.response?.statusCode else {
            return nil
        }
        switch statusCode {
        case 200..<300:
            error = nil
        case 304:
            error = ResponseError.notModified
        case 400:
            error = ResponseError.invalidRequest
        case 401:
            error = ResponseError.unauthorized
        case 403:
            error = ResponseError.accessDenied
        case 404:
            error = ResponseError.notFound
        case 405:
            error = ResponseError.methodNotAllowed
        case 422:
            error = ResponseError.validate
        case 426:
            switch response.result {
            case .success(let value):
                if let data = value as? [String: Any],
                    let lastestVersion = data[SerializationKeys.lastestVersion] as? Int ,
                    let url = data[Config.apiBaseUrl()] as? String {
                    error = ResponseError.forceUpdate(version: lastestVersion, installedUrl: url)
                } else {
                    error = ResponseError.noStatusCode
                }
            case .failure(let e):
                error = e
            }

        case 500:
            error = ResponseError.serverError
        case 502:
            error = ResponseError.badGateway
        case 503:
            error = ResponseError.serviceUnavailable
        case 504:
            error = ResponseError.gatewayTimeout
        default:
            error = ResponseError.unknown(statusCode: statusCode)
        }
        return error
    }
}

// MARK: Public methods
extension APIService {

    public func request<T: Himotoki.Decodable>(_ input: APIInputBase) -> Observable<T> {
        return _request(input)
            .map { data -> T in
                if let _ = data as? [String: Any], let object = try? T.decodeValue(data) {
                    return object
                } else {
                    throw APIError.invalidResponseData(data: data)
                }
        }
    }

    public func requestNoResponse(_ input: APIInputBase) -> Observable<(HTTPURLResponse, Any)> {
        let urlRequest = configRequest(input)
        return manager
            .rx
            .request(urlRequest: urlRequest!)
            .flatMap { dataRequest -> Observable<(HTTPURLResponse, Any)> in
                return dataRequest.rx.responseJSON()
        }
    }

    public func requestArray<T: Himotoki.Decodable>(_ input: APIInputBase) -> Observable<[T]> {
        return _request(input)
            .map { data -> [T] in
                if let _ = data as? [[String: Any]], let object = try? [T].decode(data) {
                    return object
                } else {
                    throw APIError.invalidResponseData(data: data)
                }
        }
    }

}
