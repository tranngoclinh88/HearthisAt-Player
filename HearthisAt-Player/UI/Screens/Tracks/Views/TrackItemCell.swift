//
//  TrackItemCell.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class TrackItemCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    // MARK: Properties
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var duration: String? {
        didSet {
            durationLabel.text = duration
        }
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
}
