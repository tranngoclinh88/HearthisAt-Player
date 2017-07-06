//
//  FeedItemCell.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import AlamofireImage

class FeedItemCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var avatarImageView: AvatarImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    // MARK: Properties
    
    var index: Int? {
        didSet {
            guard let index = index else { return }
            indexLabel.text = String(describing: index)
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    var imageUrl: URL? {
        didSet {
            avatarImageView.image = nil
            guard let imageUrl = imageUrl else {
                return
            }
            
            avatarImageView.af_setImage(withURL: imageUrl,
                                        placeholderImage: nil,
                                        imageTransition: .crossDissolve(0.2),
                                        runImageTransitionIfCached: false,
                                        completion: nil)
            // TODO - Image loading
        }
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
}
