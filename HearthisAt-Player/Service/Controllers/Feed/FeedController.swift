//
//  FeedController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol FeedController: Controller {
    
    func loadFeed(of kind: TrackFeed.Kind,
                  pageIndex: Int,
                  count: Int,
                  success: ((TrackFeed) -> Void)?,
                  failure: ((Error) -> Void)?)
}
