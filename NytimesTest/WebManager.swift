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
    
    typealias responseCompletion = ((Bool?, NSError?) -> Void)?
    
    private let baseUrl = {
        return AppConstants.BaseURL.appendingPathComponent("svc/mostpopular/v2/")
    }()
    
    func getEmailed(completion: responseCompletion = nil) {
        let path = baseUrl.appendingPathComponent(PathURL.Emailer)
        Alamofire.request(WebManager.insertApiKey(in: path), method: .get, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.proceedResponse(response: response, entityName: NSStringFromClass(EmailedArticle.self)) { (status, error) in
                completion?(status, error)
            }
        }
    }
    
    func getShared(completion: responseCompletion = nil) {
        let path = baseUrl.appendingPathComponent(PathURL.Shared)
        Alamofire.request(WebManager.insertApiKey(in: path), method: .get, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.proceedResponse(response: response, entityName: NSStringFromClass(SharedArticle.self)) { (status, error) in
                completion?(status, error)
            }
        }
    }
    
    func getViewed(completion: responseCompletion = nil) {
        let path = baseUrl.appendingPathComponent(PathURL.Viewed)
        Alamofire.request(WebManager.insertApiKey(in: path), method: .get, encoding: JSONEncoding.default).responseJSON { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.proceedResponse(response: response, entityName: NSStringFromClass(ViewedArticle.self)) { (status, error) in
                completion?(status, error)
            }
        }
    }
    
    func isNetworkReachable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private func proceedResponse(response: DataResponse<Any>, entityName: String, completion: responseCompletion = nil) {
        var isSuccess: Bool?
        var errorCompletion: NSError?
        switch response.result {
        case .success(let response):
            if let json = response as? [String: Any], let status = json["status"] as? String {
                if let results = json["results"] as? [[String: Any]], status == "OK" {
                    results.forEach() {
                        do {
                            try Sync.insertOrUpdate($0, inEntityNamed: entityName, using: BusinessLayer.shared.dateBase.persistentContainer.viewContext)

                        } catch {
                            isSuccess = false
                            errorCompletion = NSError.errorWithCode(errorCode: .Sync, message: error.localizedDescription)
                            completion?(isSuccess, errorCompletion)
                            return
                        }
                    }
                    isSuccess = true
                } else {
                    isSuccess = false
                    errorCompletion = NSError.errorWithCode(errorCode: .ApiKey, message: "Api-key is wrong")
                }
            } else {
                isSuccess = false
                errorCompletion = NSError.errorWithCode(errorCode: .Parse, message: "Response parse error")
            }
        case .failure(let error):
            isSuccess = false
            errorCompletion = NSError.errorWithCode(errorCode: .Server, message: error.localizedDescription)
        }
        completion?(isSuccess, errorCompletion)
    }
    
    private static func insertApiKey(in path: URL) -> URL {
        return URL(string: path.absoluteString + "?api-key=" + Constants.ApiKey) ?? path
    }
}
