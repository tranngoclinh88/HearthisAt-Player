//
//  MutablePlaybackItem.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class MutablePlaybackItem<T : Playable>: PlayableItem<T> {
    
    private var _currentState: PlayableItem<T>.State = .ready
    override var currentState: PlayableItem<T>.State {
        set {
            _currentState = newValue
            updateListeners({ $0.0.playableItem(self, didUpdate: newValue) })
        } get {
            return _currentState
        }
    }
    
}
