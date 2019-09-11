//
//  MainViewController.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: BaseViewController {
    private var selectArticleType = ArticleType.Emailer {
        didSet {
            updateResultsController()
        }
    }
    private var resultsController: NSFetchedResultsController<NSManagedObject>!
    @IBOutlet private weak var tabBar: UITabBar!
    @IBOutlet private weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateResultsController()
    }
    
    override func configureView() {
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "NewYorkTimes", size: 20)!]
        tabBar.selectedItem = tabBar.items?.first
        tableView.backgroundColor = AppConstants.MainAppColor
    }
    
    private func updateResultsController() {
        switch selectArticleType {
        case .Emailer:
            BusinessLayer.shared.webManager.getEmailed { [weak self] (isSuccess, error) in
                if let isSuccess = isSuccess, let error = error, !isSuccess {
                    self?.proceedError(error: error)
                }
            }
        case .Shared:
            BusinessLayer.shared.webManager.getShared() { [weak self] (isSuccess, error) in
                if let isSuccess = isSuccess, let error = error, !isSuccess {
                    self?.proceedError(error: error)
                }
            }
        case .Viewed:
            BusinessLayer.shared.webManager.getViewed() { [weak self] (isSuccess, error) in
                if let isSuccess = isSuccess, let error = error, !isSuccess {
                    self?.proceedError(error: error)
                }
            }
        default:
            break
        }
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Replace
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Replace
        return UITableViewCell()
    }
}

extension MainViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectArticleType = ArticleType.selectType(by: item.tag)
    }
}
