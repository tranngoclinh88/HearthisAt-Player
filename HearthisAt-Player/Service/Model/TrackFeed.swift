//
//  TrackFeed.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class TrackFeed: PagedResults<Track> {
 
    // MARK: Types
    
    enum Kind: String {
        case popular = "popular"
        case new = "new"
    }
    
    // MARK: Properties
    
    let kind: Kind
    
    // MARK: Init
    
    init(kind: Kind, pageSize: Int) {
        self.kind = kind
        super.init(with: pageSize)
    }
}
