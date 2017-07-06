//
//  FeedItemCell.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class FeedItemCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var avatarImageView: AvatarImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var songCountLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
}
