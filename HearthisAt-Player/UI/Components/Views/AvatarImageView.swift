//
//  AvatarImageView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

@IBDesignable class AvatarImageView: ImageViewComponent {
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        layer.cornerRadius = bounds.size.width / 2.0
    }
}
