//
//  CellIdentifying.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation

protocol CellIdentifying {
    static var nibName: String { get }
    static var reuseIdentifier: String { get }
}
