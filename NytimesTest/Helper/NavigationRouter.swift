//
//  NavigationRouter.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/10/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit

class NavigationRouter: NSObject {
    
    private let transitionFade = { () -> CATransition in
        let transition: CATransition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade;
        return transition
    }
    
    private var rootViewController: UIViewController {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("Can not get ViewController")
        }
        return viewController
    }
    
    private func pushViewController(navigation: UINavigationController? = nil, controller: UIViewController) {
        if let navigation = navigation {
            navigation.view.layer.add(transitionFade(), forKey: kCATransition)
            navigation.pushViewController(controller, animated: false)
        } else {
            pushViewController(navigation: currentNavigation(), controller: controller)
        }
    }
    
    func currentNavigation() -> UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    func showDetailViewController(isFromStart: Bool) {
        guard let viewController = DetailViewController.build(storyboardId: UIStoryboard.Detail, inStoryboard: UIStoryboard.main) as? DetailViewController else {
            return
        }
        currentNavigation()?.pushViewController(viewController, animated: true)
    }
}
