//
//  DetailViewController.swift
//  NytimesTest
//
//  Created by DeveloperMBPRO on 9/9/19.
//  Copyright © 2019 Test project. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var entity: Any? = nil
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var additionalLabel: UILabel!
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var createDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        checkEntity()
        
    }
    
    private func checkEntity() {
        if let entity = entity as? EmailedArticle, let media = entity.media?.allObjects.first as? Media, let mediaMetadata = media.mediaMetadata?.allObjects.first as? MediaMetadata {
            setupValue(title: entity.title, descriptionArticle: entity.abstract, additionalText: entity.adxKeywords, imageArticle: URL(string: mediaMetadata.url ?? ""), createArticle: entity.publishedDate)
        } else if let entity = entity as? SharedArticle, let media = entity.media?.allObjects.first as? Media, let mediaMetadata = media.mediaMetadata?.allObjects.first as? MediaMetadata {
            setupValue(title: entity.title, descriptionArticle: entity.abstract, additionalText: entity.adxKeywords, imageArticle: URL(string: mediaMetadata.url ?? ""), createArticle: entity.publishedDate)
        } else if let entity = entity as? ViewedArticle, let media = entity.media?.allObjects.first as? Media, let mediaMetadata = media.mediaMetadata?.allObjects.first as? MediaMetadata {
            setupValue(title: entity.title, descriptionArticle: entity.abstract, additionalText: entity.adxKeywords, imageArticle: URL(string: mediaMetadata.url ?? ""), createArticle: entity.publishedDate)
        }
    }
    
    private func setupValue(title: String?, descriptionArticle: String?, additionalText: String?, imageArticle: URL?, createArticle: String?) {
        titleLabel.text = title
        detailLabel.text = descriptionArticle
        additionalLabel.text = additionalText
        articleImage.sd_setImage(with: imageArticle)
        createDateLabel.text = createArticle
    }

}

