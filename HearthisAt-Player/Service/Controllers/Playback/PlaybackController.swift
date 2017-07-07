//
//  PlaybackController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Listenable

protocol PlaybackControllerNotifyable {
    
    func playbackController(_ controller: PlaybackController,
                            didUpdate state: PlayableItem.State,
                            of item: PlayableItem)
}

protocol PlaybackController: Controller {
    
    var notificationService: Listenable<PlaybackControllerNotifyable> { get }
    
    func generatePlayableItem(for object: Playable) -> PlayableItem
}
