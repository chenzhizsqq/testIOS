//
//  NetworkManager.swift
//  NetworkChen
//
//  Created by chenzhizs on 2020/10/12.
//  Copyright © 2020 chenzhizs. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

private let NetworkAPIBaseURL = "https://raw.githubusercontent.com/chenzhizsqq/testIOS/master/testIOS/Resources/"

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    var commonHeaders: HTTPHeaders{["user_id":"123" , "token":"XXXXXX"] }
    
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping (Result<Data, Error>) ->Void) -> DataRequest
    {
        AF.request(
            NetworkAPIBaseURL + path,
            parameters: parameters,
            headers: commonHeaders,
            requestModifier: {$0.timeoutInterval = 15 }
        ).responseData
        {
            response in
            switch response.result
            {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest
    {
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   parameters:parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: {$0.timeoutInterval = 15 }
        ).responseData
        {
            response in
            switch response.result
            {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    
    
    private func handleError(_ error: AFError) -> NetworkRequestResult
    {
        if let underlyingError = error.underlyingError
        {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet
                || code == NSURLErrorTimedOut
                || code == NSURLErrorInternationalRoamingOff
                || code == NSURLErrorDataNotAllowed
                || code == NSURLErrorCannotFindHost
                || code == NSURLErrorCannotConnectToHost
                || code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题: \(code)"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
}
