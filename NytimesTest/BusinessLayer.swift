//
//  BusinessLayer.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation

class BusinessLayer: NSObject {
    static let shared = BusinessLayer()
    
    let webManager = WebManager()
    let dateBase = DataBaseManager()
    
    private override init() {}
}
