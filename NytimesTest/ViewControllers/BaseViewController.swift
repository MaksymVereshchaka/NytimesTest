//
//  BaseViewController.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private enum TabBarItem: Int {
        case Emailer = 0
        case Shared
        case Viewed
    }
    

    @IBOutlet private weak var navItem: UINavigationItem!
    @IBOutlet private weak var tabBar: UITabBar!
    @IBOutlet private weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Action
    
    @IBAction private func didTapMenuButton(_ sender: UIBarButtonItem) {
    }
}

extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Replace
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Replace
        return UITableViewCell()
    }
}

extension BaseViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case TabBarItem.Emailer.rawValue:
            break
        case TabBarItem.Shared.rawValue:
            break
        case TabBarItem.Viewed.rawValue:
            break
        default:
            break
        }
    }
}
