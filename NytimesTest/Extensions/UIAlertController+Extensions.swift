//
//  UIAlertController+Extensions.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/11/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    private func presentOverKeyboard(animated: Bool, completion: (() -> Void)?) {
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = BaseViewController()
        alertWindow.windowLevel = UIWindow.Level.alert
        alertWindow.isHidden = false
        alertWindow.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
    static func showAlert(title: String? = "Error", message: String?, cancelButtonTitle: String? = "OK", withTitleButtons: [String]? = nil, completion: ((_ buttonIndex : Int) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = AppConstants.TintColor
        if let title = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: title, style: .cancel) { (sender) in
                if let completion = completion {
                    completion(0)
                }
            }
            alert.addAction(cancelAction)
        }
        if let titleButtons = withTitleButtons {
            for (current, title) in titleButtons.enumerated() {
                let buttonAction = UIAlertAction(title: title, style: .default) { (sender) in
                    if let completion = completion {
                        completion(current + 1)
                    }
                }
                alert.addAction(buttonAction)
            }
        }
        alert.presentOverKeyboard(animated: true, completion: nil)
    }
}
