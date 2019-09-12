//
//  BaseViewController.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/10/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    static func build(storyboardId: String, inStoryboard storyboard: UIStoryboard) -> BaseViewController? {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId) as? BaseViewController else {
            return nil
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func configureView() {
        
    }
    
    func proceedError(error: NSError) {
        UIAlertController.showAlert(message: error.localizedDescription)
    }
}
