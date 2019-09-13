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
    private enum Constants {
        static let PublishedDate = "publishedDate"
        static let SelectedFavorite = UIImage(named: "selected_heart")
        static let UnselectedFavorite = UIImage(named: "unselected_heart")
    }
    private var selectArticleType = ArticleType.Emailed {
        didSet {
            updateResultsController(with: selectArticleType, onlyFavorite: showOnlyFavorite)
        }
    }
    
    private var resultsController: NSFetchedResultsController<NSManagedObject>!
    private var showOnlyFavorite = false {
        didSet {
            favoriteBarButtonItem.image = showOnlyFavorite ? Constants.SelectedFavorite : Constants.UnselectedFavorite
        }
    }
    
    @IBOutlet private weak var tabBar: UITabBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var favoriteBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateResultsController()
    }
    
    override func configureView() {
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "NewYorkTimes", size: 20)!]
        tabBar.selectedItem = tabBar.items?.first
        tableView.backgroundColor = AppConstants.MainAppColor
        tableView.tableFooterView = UIView()
    }
    
    private func updateResultsController(with type: ArticleType = .Emailed, onlyFavorite: Bool = false, fromInternet: Bool = true) {
        var entityName = ""
        switch type {
        case .Emailed:
            entityName = NSStringFromClass(EmailedArticle.self)
        case .Shared:
            entityName = NSStringFromClass(SharedArticle.self)
        case .Viewed:
            entityName = NSStringFromClass(ViewedArticle.self)
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Constants.PublishedDate, ascending: false)]
        if onlyFavorite {
            fetchRequest.predicate = NSPredicate(format: "isFavorite == YES")
        }
        resultsController = nil
        resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: BusinessLayer.shared.dateBase.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<NSManagedObject>
        try? resultsController.performFetch()
        resultsController.delegate = self
        tableView.setContentOffset(.zero, animated: true)
        if fromInternet {
            updateDataFromInternet(by: type)
        }
    }
    
    private func updateDataFromInternet(by type: ArticleType) {
        switch selectArticleType {
        case .Emailed:
            BusinessLayer.shared.webManager.getEmailed { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                if let isSuccess = isSuccess, let error = error, !isSuccess {
                    self.proceedError(error: error)
                }
            }
        case .Shared:
            BusinessLayer.shared.webManager.getShared() { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                if let isSuccess = isSuccess, let error = error, !isSuccess {
                    self.proceedError(error: error)
                }
            }
        case .Viewed:
            BusinessLayer.shared.webManager.getViewed() { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                if let isSuccess = isSuccess, let error = error, !isSuccess {
                    self.proceedError(error: error)
                }
            }
        }
    }
    
    @IBAction private func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        showOnlyFavorite = !showOnlyFavorite
        updateResultsController(with: selectArticleType, onlyFavorite: showOnlyFavorite, fromInternet: false)
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let resultsController = resultsController, let sectionInfo = resultsController.sections?.first else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: MainTableViewCell.self, for: indexPath)
        cell.delegate = self
        let data = resultsController.object(at: indexPath)
        if let emailed = data as? EmailedArticle, let media = emailed.media?.allObjects.first as? Media, let mediaMetadata = media.mediaMetadata?.allObjects.first as? MediaMetadata {
            cell.setupCell(title: emailed.title, timeUpdate: emailed.publishedDate, section: emailed.section, imageURL: URL(string: mediaMetadata.url ?? ""), isFavorite: emailed.isFavorite, indexPath: indexPath)
        } else if let shared = data as? SharedArticle, let media = shared.media?.allObjects.first as? Media, let mediaMetadata = media.mediaMetadata?.allObjects.first as? MediaMetadata {
            cell.setupCell(title: shared.title, timeUpdate: shared.publishedDate, section: shared.section, imageURL: URL(string: mediaMetadata.url ?? ""), isFavorite: shared.isFavorite, indexPath: indexPath)
        } else if let viewed = data as? ViewedArticle, let media = viewed.media?.allObjects.first as? Media, let mediaMetadata = media.mediaMetadata?.allObjects.first as? MediaMetadata {
            cell.setupCell(title: viewed.title, timeUpdate: viewed.publishedDate, section: viewed.section, imageURL: URL(string: mediaMetadata.url ?? ""), isFavorite: viewed.isFavorite, indexPath: indexPath)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = resultsController.object(at: indexPath)
        BusinessLayer.shared.router.showDetailViewController(articleData: data)
    }
}

extension MainViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectArticleType = ArticleType.selectType(by: item.tag)
    }
}

extension MainViewController: MainTableViewCellDelegate {
    func mainTableViewCellDidTapFavorite(selected: Bool, indexPathCell: IndexPath) {
        if let entity = resultsController.object(at: indexPathCell) as? EmailedArticle {
            entity.isFavorite = selected
        } else if let entity = resultsController.object(at: indexPathCell) as? SharedArticle {
            entity.isFavorite = selected
        } else if let entity = resultsController.object(at: indexPathCell) as? ViewedArticle {
            entity.isFavorite = selected
        }
        BusinessLayer.shared.dateBase.saveContext()
    }
}

extension MainViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
    }
}
