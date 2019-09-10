//
//  ArticleType.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/10/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation

enum ArticleType: String {
    case Emailer = "emailer"
    case Shared = "shared"
    case Viewed = "viewed"
    case Favorited = "favorited"
    
    static func selectType(by index: Int) -> ArticleType {
        switch index {
        case 0:
            return ArticleType.Emailer
        case 1:
            return ArticleType.Shared
        case 2:
            return ArticleType.Viewed
        case 3:
            return ArticleType.Favorited
        default:
            return ArticleType.Emailer
        }
    }
}
