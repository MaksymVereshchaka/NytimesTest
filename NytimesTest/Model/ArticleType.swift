//
//  ArticleType.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/10/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation

enum ArticleType: String {
    case Emailed = "emailed"
    case Shared = "shared"
    case Viewed = "viewed"
    
    static func selectType(by index: Int) -> ArticleType {
        switch index {
        case 0:
            return ArticleType.Emailed
        case 1:
            return ArticleType.Shared
        case 2:
            return ArticleType.Viewed
        default:
            return ArticleType.Emailed
        }
    }
}
