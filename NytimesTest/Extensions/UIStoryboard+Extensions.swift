//
//  UIStoryboard+Extensions.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/10/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static let Main = "MainViewController"
    static let Detail = "DetailViewController"
    
    class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle:nil)
    }
}
