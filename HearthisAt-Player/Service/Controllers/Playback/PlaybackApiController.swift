//
//  PlaybackApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class PlaybackApiController: ApiController, PlaybackController {
    
    // MARK: Properties
    
    // MARK: Methods
    
    func generatePlayableItem<T>(for object: T) -> PlayableItem<T> {
        return MutablePlaybackItem<T>(for: object, responder: self)
    }
}

extension PlaybackApiController: PlayableItemResponder {
 
    func playableItem<T>(requestPlay item: PlayableItem<T>) {
        print(item.object.contentUrl())
    }
    
    func playableItem<T>(requestPause item: PlayableItem<T>) {
        
    }
}
