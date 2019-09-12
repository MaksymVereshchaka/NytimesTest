//
//  NSError+Extensions.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/11/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation

extension NSError {
    
    enum Code: Int {
        case Unknown = 0
        case Parse
        case ApiKey
        case General
        case Server
        case ConnectionLost
        case Sync
    }
    
    private static let Domain = Bundle.main.bundleIdentifier ?? "error.domain"
    
    static func errorWithCode(errorCode: Code, message: String?) -> NSError {
        return NSError(domain: NSError.Domain, code: errorCode.rawValue, userInfo: [NSLocalizedDescriptionKey: message ?? "Unknown error"])
    }
}
