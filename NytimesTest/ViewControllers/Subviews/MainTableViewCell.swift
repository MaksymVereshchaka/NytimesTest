//
//  MainTableViewCell.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit
import SDWebImage

protocol MainTableViewCellDelegate: class {
    func mainTableViewCellDidTapFavorite(selected: Bool, indexPathCell: IndexPath)
}

class MainTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var timeUpdateLabel: UILabel!
    @IBOutlet private weak var sectionLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    private var indexPathCell: IndexPath?
    
    weak var delegate: MainTableViewCellDelegate?
    
    func setupCell(title: String?, timeUpdate: String?, section: String?, imageURL: URL?, isFavorite: Bool, indexPath: IndexPath?) {
        titleLabel.text = title
        timeUpdateLabel.text = timeUpdate
        sectionLabel.text = section
        articleImage.sd_setImage(with: imageURL, completed: nil)
        favoriteButton.isSelected = isFavorite
        indexPathCell = indexPath
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        timeUpdateLabel.text = ""
        sectionLabel.text = ""
        articleImage.image = nil
    }
    
    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        delegate?.mainTableViewCellDidTapFavorite(selected: !sender.isSelected, indexPathCell: indexPathCell ?? IndexPath())
    }
}
