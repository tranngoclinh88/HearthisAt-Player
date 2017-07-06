//
//  ControllerProvider.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol ControllerProvider: class {
    
    var artistController: ArtistController { get }
    var feedController: FeedController { get }
    var tracksController: TracksController { get }
    var playbackController: PlaybackController { get }
    
}
