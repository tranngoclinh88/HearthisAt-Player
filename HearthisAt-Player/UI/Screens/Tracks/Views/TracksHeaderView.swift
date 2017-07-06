//
//  TracksHeaderView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        let innerContainer = UIView()
        innerContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(innerContainer)
        innerContainer.edges(to: view,
                             insets: EdgeInsets(top: 40.0, left: 0.0, bottom: 0.0, right: 0.0))
        
        innerContainer.addSubview(imageView)
        innerContainer.addSubview(titleLabel)
        
        imageView.size(CGSize(width: 100.0, height: 100.0))
        imageView.centerX(to: innerContainer)
        imageView.top(to: innerContainer)
        
        titleLabel.left(to: innerContainer)
        titleLabel.right(to: innerContainer)
        titleLabel.bottom(to: innerContainer)
        titleLabel.topToBottom(of: imageView, offset: 24.0)
        
        titleLabel.text = "Merrick Sapsford"
    }
}
