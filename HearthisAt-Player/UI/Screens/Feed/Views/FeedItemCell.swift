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
    weak var profileProvider: ArtistProfileProvider? {
        didSet {
            if oldValue?.delegate === self {
                oldValue?.delegate = nil
            }
            profileProvider?.delegate = self
            
            if let currentState = profileProvider?.currentState {
                updateForProfileProvider(with: currentState)
            }
        }
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        title = nil
        subtitle = nil
    }
    
    // MARK: Profile Provider
    
    fileprivate func updateForProfileProvider(with state: ArtistProfileProvider.State) {
        switch state {
            
        case .loading:
            subtitle = "screen.feed.cell.profiledetails.loading".localized()
            
        case .available(let profile):
            subtitle = generateProfileDetails(for: profile)
            
        case .failed(_):
            subtitle = "screen.feed.cell.profiledetails.unavailable".localized()
            
        default:
            subtitle = ""
        }
    }
    
    private func generateProfileDetails(for profile: ArtistProfile) -> String {
        var detailsString = ""
        if let permalink = profile.permalink {
            detailsString.append("\(permalink)")
        }
        if let trackCount = profile.trackCount {
            detailsString.append(" // \(trackCount) Tracks")
        }
        return detailsString
    }
}

extension FeedItemCell: ArtistProfileProviderDelegate {
    
    func artistProfileProvider(_ provider: ArtistProfileProvider,
                               didUpdate state: ArtistProfileProvider.State) {
        updateForProfileProvider(with: state)
    }
}
