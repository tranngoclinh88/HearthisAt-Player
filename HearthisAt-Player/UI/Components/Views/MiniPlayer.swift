//
//  MiniPlayer.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

class MiniPlayer: ViewComponent {
    
    // MARK: Properties
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 60.0)
    }
    
    private var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(8.0, 12.0, 8.0, 8.0)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        return button
    }()
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
        return titleLabel
    }()
    private var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)

        return subtitleLabel
    }()
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        blurView.edges(to: view)
        
        view.addSubview(playButton)
        playButton.top(to: view)
        playButton.leading(to: view)
        playButton.bottom(to: view)
        playButton.height(intrinsicContentSize.height)
        playButton.width(intrinsicContentSize.height)
        
        view.addSubview(titleLabel)
        titleLabel.top(to: view, offset: 10.0)
        titleLabel.leadingToTrailing(of: playButton, offset: 16.0)
        titleLabel.trailing(to: view, offset: -16.0)
        
        view.addSubview(subtitleLabel)
        subtitleLabel.topToBottom(of: titleLabel, offset: 4.0)
        subtitleLabel.leading(to: titleLabel)
        subtitleLabel.trailing(to: titleLabel)
        
        titleLabel.text = "Song Title"
        subtitleLabel.text = "Artist Name"
    }
}
