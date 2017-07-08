//
//  PlaybackController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import Listenable

protocol PlaybackControllerNotifyable {
    
    func playbackController(_ controller: PlaybackController,
                            didUpdate state: PlayableItem.State,
                            of item: PlayableItem)
}

protocol PlaybackController: Controller {
    
    /// The notification service for playback.
    var notificationService: Listenable<PlaybackControllerNotifyable> { get }
    
    /// The currently active playable item.
    var currentItem: PlayableItem? { get }
    
    /// Generate a playable item.
    ///
    /// - Parameter object: The object to play.
    /// - Returns: A playable item.
    func generatePlayableItem(for object: Playable) -> PlayableItem
    
    /// Handle Remote control event.
    ///
    /// - Parameter event: The remote event.
    func respondToRemoteControlEvent(_ event: UIEvent?)
}
