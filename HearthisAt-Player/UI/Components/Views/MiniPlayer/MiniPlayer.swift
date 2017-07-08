//
//  MiniPlayer.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

protocol MiniPlayerDelegate: class {
    
    func miniPlayer(playPauseButtonPressed miniPlayer: MiniPlayer)
}

class MiniPlayer: ViewComponent {
    
    // MARK: Types
    
    enum ButtonState {
        case play
        case pause
    }
    
    // MARK: Properties
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 64.0)
    }

    private var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        button.backgroundColor = UIColor.hta_backgroundGradient.first
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
    var buttonState: ButtonState = .play {
        didSet {
            playButton.setImage(buttonState == .play ? #imageLiteral(resourceName: "ic_play") : #imageLiteral(resourceName: "ic_pause"), for: .normal)
        }
    }
    
    weak var delegate: MiniPlayerDelegate?
    
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
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.3
        
        playButton.addTarget(self, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    // MARK: Actions
    
    func playButtonPressed(_ sender: UIButton) {
        delegate?.miniPlayer(playPauseButtonPressed: self)
    }
}
