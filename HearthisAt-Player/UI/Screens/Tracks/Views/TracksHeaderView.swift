//
//  TracksHeaderView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints
import AlamofireImage

protocol TracksHeaderViewDelegate: class {
    
    func tracksHeaderView(backButtonPressed view: TracksHeaderView)
}

class TracksHeaderView: ViewComponent {
    
    // MARK: Properties
    
    private let imageView: AvatarImageView = {
        let imageView = AvatarImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .hta_title
        label.textColor = .hta_textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .hta_subtitle
        label.textColor = .hta_textSecondary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    private let bottomSeparator: UIView = {
        let separator = UIView()
        separator.isUserInteractionEnabled = false
        separator.backgroundColor = .white
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    weak var delegate: TracksHeaderViewDelegate?
    
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
    var avatarUrl: URL? {
        didSet {
            guard let avatarUrl = avatarUrl else {
                imageView.image = nil
                return
            }
            imageView.af_setImage(withURL: avatarUrl,
                                  placeholderImage: nil,
                                  imageTransition: .crossDissolve(0.2),
                                  runImageTransitionIfCached: false,
                                  completion: nil)
        }
    }
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        view.addSubview(bottomSeparator)
        bottomSeparator.leading(to: view)
        bottomSeparator.trailing(to: view)
        bottomSeparator.bottom(to: view)
        bottomSeparator.height(0.5)
        
        let innerContainer = UIView()
        innerContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(innerContainer)
        innerContainer.top(to: view, offset: 40.0)
        innerContainer.left(to: view)
        innerContainer.right(to: view)
        innerContainer.bottomToTop(of: bottomSeparator, offset: -20.0)
        
        innerContainer.addSubview(imageView)
        innerContainer.addSubview(backButton)
        innerContainer.addSubview(titleLabel)
        innerContainer.addSubview(subtitleLabel)
        
        imageView.size(CGSize(width: 100.0, height: 100.0))
        imageView.centerX(to: innerContainer)
        imageView.top(to: innerContainer)
        
        backButton.left(to: innerContainer, offset: 8.0)
        backButton.centerY(to: imageView)
        backButton.size(CGSize(width: 40.0, height: 40.0))
        
        titleLabel.left(to: innerContainer, offset: 8.0)
        titleLabel.right(to: innerContainer, offset: -8.0)
        titleLabel.topToBottom(of: imageView, offset: 24.0)
        
        subtitleLabel.left(to: innerContainer, offset: 8.0)
        subtitleLabel.right(to: innerContainer, offset: -8.0)
        subtitleLabel.topToBottom(of: titleLabel, offset: 6.0)
        subtitleLabel.bottom(to: innerContainer)
        
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    func backButtonPressed(_ sender: UIButton) {
        delegate?.tracksHeaderView(backButtonPressed: self)
    }
}
