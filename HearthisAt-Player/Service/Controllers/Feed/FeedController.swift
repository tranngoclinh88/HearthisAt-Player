//
//  FeedController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol FeedController: Controller {
    
    // MARK: Properties
    
    /// Feed of popular tracks.
    var popularFeed: TrackFeed { get }
    /// Feed of new tracks.
    var newFeed: TrackFeed { get }
    
    // MARK: Methods
    
    /// Load a feed.
    ///
    /// - Parameters:
    ///   - kind: The type of feed to load.
    ///   - pageIndex: The page index to load.
    ///   - count: The number of feed items to load.
    ///   - success: Execution on successful method.
    ///   - failure: Execution on failed method.
    func loadFeed(of kind: TrackFeed.Kind,
                  pageIndex: Int,
                  count: Int,
                  success: ((_ feed: TrackFeed, _ newPage: [Track]) -> Void)?,
                  failure: MethodFailure?)
    
    /// Load the next page of a feed.
    ///
    /// - Parameters:
    ///   - feed: The feed.
    ///   - success: Execution on successful method.
    ///   - failure: Execution on failed method.
    func loadNextPage(of feed: TrackFeed,
                      success: ((_ feed: TrackFeed, _ newPage: [Track]) -> Void)?,
                      failure: MethodFailure?)
}
