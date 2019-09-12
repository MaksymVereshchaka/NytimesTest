//
//  NSObject+Extensions.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    class var nameOfClass: String {
        guard let className = NSStringFromClass(self).components(separatedBy: ".").last else {
            fatalError("Class could not be instantiated because it was not found on the project")
        }
        return className
    }
    class var nameOfApp: String {
        guard let nameOfApp = NSStringFromClass(self).components(separatedBy: ".").first else {
            fatalError("Class could not be instantiated because it was not found on the project")
        }
        return nameOfApp
    }
}
