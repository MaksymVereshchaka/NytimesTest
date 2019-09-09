//
//  WebManager.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation
import Alamofire

class WebManager: NSObject {
    private enum Constants {
        static let ApiKey = "6v7ttDFGAdg0iFfRak5e9PZmIaUgfE7B"
        static let SecretKey = "qROFf7HGH25BGdZb"
    }
    
    private enum PathURL {
        static let Emailer = "emailed/7.json"
        static let Shared = "shared/1/facebook.json"
        static let Viewed = "viewed/7.json"
    }
    
    private let baseUrl = {
        return AppConstants.BaseURL.appendingPathComponent("svc/mostpopular/v2/")
    }()
    
    func getEmailed() {
        Alamofire.request(baseUrl.appendingPathComponent(PathURL.Emailer), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebManager.headersRequest()).responseJSON { (response) in
            switch response.result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    func getShared() {
        Alamofire.request(baseUrl.appendingPathComponent(PathURL.Shared), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebManager.headersRequest()).responseJSON { (response) in
            switch response.result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    func getViewed() {
        Alamofire.request(baseUrl.appendingPathComponent(PathURL.Viewed), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebManager.headersRequest()).responseJSON { (response) in
            switch response.result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    func isNetworkReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private static func headersRequest() -> [String: String] {
        return ["Content-Type": "application/json",
                "api-key": Constants.ApiKey]
    }
}
