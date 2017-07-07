//
//  FeedTitleHeaderView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

class FeedTitleHeaderView: ViewComponent {
    
    // MARK: Properties
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 80.0)
    }
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 34.0, weight: UIFontWeightBold)
        return titleLabel
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        view.addSubview(titleLabel)
        titleLabel.leading(to: view, offset: 16.0)
        titleLabel.trailing(to: view, offset: -16.0)
        titleLabel.centerY(to: view)
    }
}
