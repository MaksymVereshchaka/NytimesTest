//
//  WebManager.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation
import Alamofire
import Sync

class WebManager: NSObject {
    private enum Constants {
        static let ApiKey = "6v7ttDFGAdg0iFfRak5e9PZmIaUgfE7B"
        static let SecretKey = "qROFf7HGH25BGdZb"
    }
    
    private enum PathURL {
        static let Emailer = "emailed/30.json"
        static let Shared = "shared/30.json"
        static let Viewed = "viewed/30.json"
    }
    
    private let baseUrl = {
        return AppConstants.BaseURL.appendingPathComponent("svc/mostpopular/v2/")
    }()
    
    func getEmailed() {
        Alamofire.request(baseUrl.appendingPathComponent(PathURL.Emailer), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebManager.headersRequest()).responseJSON { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.proceedResponse(response: response, entityName: NSStringFromClass(EmailedArticle.self))
        }
    }
    
    func getShared() {
        Alamofire.request(baseUrl.appendingPathComponent(PathURL.Shared), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebManager.headersRequest()).responseJSON { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.proceedResponse(response: response, entityName: NSStringFromClass(SharedArticle.self))
        }
    }
    
    func getViewed() {
        Alamofire.request(baseUrl.appendingPathComponent(PathURL.Viewed), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebManager.headersRequest()).responseJSON { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.proceedResponse(response: response, entityName: NSStringFromClass(SharedArticle.self))
        }
    }
    
    func isNetworkReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private func proceedResponse(response: DataResponse<Any>, entityName: String) {
        switch response.result {
        case .success(let response):
            if let json = response as? [String: Any], let status = json["status"] as? String, status == "OK", let results = json["results"] as? [[String: Any]] {
                Sync.changes(results, inEntityNamed: entityName, dataStack: BusinessLayer.shared.dateBase.dataStack) { (error) in
                    print(error?.localizedDescription ?? "Sync error")
                }
            } else {
                // error
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private static func headersRequest() -> [String: String] {
        return [//"Content-Type": "application/json",
                "api-key": Constants.ApiKey]
    }
}
